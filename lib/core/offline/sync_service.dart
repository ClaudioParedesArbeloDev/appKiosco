import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../../services/secure_storage_service.dart';
import '../../services/sync_api_service.dart';
import 'app_database.dart';

/// Sincroniza la base local con el backend, en este orden:
///
/// 1. Reproduce la cola de operaciones de negocio diferidas (abrir/cerrar
///    caja, movimiento, crear venta, crear cliente) contra los endpoints
///    reales de siempre — no son filas a insertar, son la misma llamada
///    que se hubiera hecho online, para que el server ejecute toda su
///    lógica (precio, descuento, numeración, límite de plan, movimientos).
/// 2. Sube lo pendiente de `articulos` (tabla "editable" simple).
/// 3. Baja lo nuevo del servidor (`pull`), en ese orden para que el pull no
///    pise un cambio local que todavía no se mandó.
class SyncService {
  SyncService(this._db, this._api, this._storage, this._apiClient);

  final AppDatabase _db;
  final SyncApiService _api;
  final SecureStorageService _storage;
  final ApiClient _apiClient;

  static const _lastPullKey = 'last_pull_at';

  Future<void> sincronizar() async {
    await _reproducirOperacionesPendientes();
    await _pushPendientes();
    await _pull();
  }

  Future<void> _reproducirOperacionesPendientes() async {
    final pendientes = await (_db.select(_db.operacionesPendientes)
          ..where((t) => t.estado.equals('pendiente'))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();

    for (final operacion in pendientes) {
      final payload = jsonDecode(operacion.payload) as Map<String, dynamic>;

      try {
        await _reproducirUna(operacion.tipoOperacion, payload);
        await (_db.delete(_db.operacionesPendientes)..where((t) => t.id.equals(operacion.id)))
            .go();
        await _marcarEntidadSincronizada(operacion.tipoOperacion, operacion.entidadLocalId);
      } on DioException catch (e) {
        if (e.response == null) {
          // Se cortó la conexión a mitad de la corrida — paramos acá, se
          // reintenta desde el principio en el próximo sincronizar().
          return;
        }

        // El server rechazó la operación (422, etc.) — no se reintenta en
        // loop, queda marcada para que el dueño la revise a mano (poco
        // volumen esperado en un kiosco chico).
        await (_db.update(_db.operacionesPendientes)..where((t) => t.id.equals(operacion.id)))
            .write(
          OperacionesPendientesCompanion(
            estado: const Value('fallida'),
            ultimoError: Value(e.response?.data?.toString() ?? e.message ?? 'Error desconocido'),
            intentos: Value(operacion.intentos + 1),
          ),
        );
      }
    }
  }

  Future<Response> _reproducirUna(String tipoOperacion, Map<String, dynamic> payload) {
    switch (tipoOperacion) {
      case 'crear_cliente':
        return _apiClient.dio.post(ApiEndpoints.clientes, data: payload);
      case 'abrir_caja':
        return _apiClient.dio.post(ApiEndpoints.cajaAbrir, data: payload);
      case 'registrar_movimiento':
        return _apiClient.dio.post(ApiEndpoints.cajaMovimiento, data: payload);
      case 'crear_venta':
        return _apiClient.dio.post(ApiEndpoints.ventas, data: payload);
      case 'cerrar_caja':
        return _apiClient.dio.post(ApiEndpoints.cajaCerrar, data: payload);
      default:
        throw ArgumentError('Tipo de operación offline desconocido: $tipoOperacion');
    }
  }

  /// Saca el flag `pendienteSync` de la fila local recién confirmada. Los
  /// valores que solo el server puede calcular (número de venta real,
  /// monto_final_calculado de un cierre de caja) los completa el `_pull()`
  /// que corre justo después, no acá.
  Future<void> _marcarEntidadSincronizada(String tipoOperacion, String entidadLocalId) async {
    switch (tipoOperacion) {
      case 'crear_cliente':
        await (_db.update(_db.localClientes)..where((t) => t.id.equals(entidadLocalId)))
            .write(const LocalClientesCompanion(pendienteSync: Value(false)));
      case 'abrir_caja':
      case 'cerrar_caja':
        await (_db.update(_db.localCajas)..where((t) => t.id.equals(entidadLocalId)))
            .write(const LocalCajasCompanion(pendienteSync: Value(false)));
      case 'registrar_movimiento':
        await (_db.update(_db.localCajaMovimientos)..where((t) => t.id.equals(entidadLocalId)))
            .write(const LocalCajaMovimientosCompanion(pendienteSync: Value(false)));
      case 'crear_venta':
        await (_db.update(_db.localVentas)..where((t) => t.id.equals(entidadLocalId)))
            .write(const LocalVentasCompanion(pendienteSync: Value(false)));
    }
  }

  Future<void> _pushPendientes() async {
    final pendientes = await _db.select(_db.syncQueueItems).get();
    final deArticulos = pendientes.where((p) => p.tabla == 'articulos').toList();
    if (deArticulos.isEmpty) return;

    final deviceId = await _storage.getOrCreateDeviceId();
    final payloadArticulos =
        deArticulos.map((p) => jsonDecode(p.payload) as Map<String, dynamic>).toList();

    // Si esto tira (sin conexión, error del server), no se limpia nada de
    // la cola — se reintenta en el próximo sincronizar().
    await _api.push(deviceId: deviceId, changes: {'articulos': payloadArticulos});

    final idsEntidad = deArticulos.map((p) => p.entidadId).toSet();
    final idsCola = deArticulos.map((p) => p.id).toSet();

    await _db.batch((batch) {
      batch.deleteWhere(_db.syncQueueItems, (t) => t.id.isIn(idsCola));
      batch.update(
        _db.localArticulos,
        const LocalArticulosCompanion(pendienteSync: Value(false)),
        where: (t) => t.id.isIn(idsEntidad),
      );
    });
  }

  Future<void> _pull() async {
    final since = await _leerUltimoPull();
    final response = await _api.pull(since: since);
    final changes = response.data['changes'] as Map<String, dynamic>?;
    final serverTime = response.data['server_time'] as String;

    await _pullArticulos((changes?['articulos'] as List?) ?? const []);
    await _pullClientes((changes?['clientes'] as List?) ?? const []);
    await _pullCajas((changes?['cajas'] as List?) ?? const []);
    await _pullCajaMovimientos((changes?['caja_movimientos'] as List?) ?? const []);
    await _pullVentas((changes?['ventas'] as List?) ?? const []);
    await _pullVentaItems((changes?['venta_items'] as List?) ?? const []);

    await _guardarUltimoPull(serverTime);
  }

  Future<void> _pullArticulos(List articulos) async {
    // No pisar filas con cambios locales sin subir todavía — se
    // reconcilian solas en el próximo sincronizar() (push antes que pull).
    final pendientesIds = (await (_db.select(_db.localArticulos)
              ..where((t) => t.pendienteSync.equals(true)))
            .get())
        .map((a) => a.id)
        .toSet();

    await _db.batch((batch) {
      for (final fila in articulos) {
        final json = fila as Map<String, dynamic>;
        if (pendientesIds.contains(json['id'])) continue;

        batch.insert(
          _db.localArticulos,
          _companionArticuloFromServerJson(json),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  LocalArticulosCompanion _companionArticuloFromServerJson(Map<String, dynamic> json) {
    return LocalArticulosCompanion.insert(
      id: json['id'] as String,
      codigoBarras: Value(json['codigo_barras'] as String?),
      codigoInterno: Value(json['codigo_interno'] as String?),
      descripcion: json['descripcion'] as String,
      marca: Value(json['marca'] as String?),
      rubro: Value(json['rubro'] as String?),
      imagenUrl: Value(json['imagen_url'] as String?),
      precioCosto: json['precio_costo'] as int,
      precioVenta: json['precio_venta'] as int,
      precioPromocional: Value((json['precio_promocional'] as num?)?.toInt()),
      promocionDesde: Value(
        json['promocion_desde'] == null ? null : DateTime.parse(json['promocion_desde'] as String),
      ),
      promocionHasta: Value(
        json['promocion_hasta'] == null ? null : DateTime.parse(json['promocion_hasta'] as String),
      ),
      activo: Value(json['activo'] as bool? ?? true),
      version: Value(json['version'] as int? ?? 1),
      pendienteSync: const Value(false),
    );
  }

  Future<void> _pullClientes(List clientes) async {
    final pendientesIds = (await (_db.select(_db.localClientes)
              ..where((t) => t.pendienteSync.equals(true)))
            .get())
        .map((c) => c.id)
        .toSet();

    await _db.batch((batch) {
      for (final fila in clientes) {
        final json = fila as Map<String, dynamic>;
        if (pendientesIds.contains(json['id'])) continue;

        batch.insert(
          _db.localClientes,
          LocalClientesCompanion.insert(
            id: json['id'] as String,
            nombre: json['nombre'] as String,
            dniCuit: Value(json['dni_cuit'] as String?),
            condicionIva: Value(json['condicion_iva'] as String? ?? 'consumidor_final'),
            direccion: Value(json['direccion'] as String?),
            telefono: Value(json['telefono'] as String?),
            email: Value(json['email'] as String?),
            zona: Value(json['zona'] as String?),
            porcentajeDescuento: Value(json['porcentaje_descuento'] as int? ?? 0),
            activo: Value(json['activo'] as bool? ?? true),
            limiteCuentaCorriente: Value((json['limite_cuenta_corriente'] as num?)?.toInt()),
            version: Value(json['version'] as int? ?? 1),
            pendienteSync: const Value(false),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> _pullCajas(List cajas) async {
    // A diferencia de artículos/clientes, acá "pendiente" no es un
    // conflicto de edición — es una caja que todavía no terminó de
    // reproducirse (falló o se cortó la conexión a mitad). No la pisamos
    // hasta que se resuelva.
    final pendientesIds = (await (_db.select(_db.localCajas)
              ..where((t) => t.pendienteSync.equals(true)))
            .get())
        .map((c) => c.id)
        .toSet();

    await _db.batch((batch) {
      for (final fila in cajas) {
        final json = fila as Map<String, dynamic>;
        if (pendientesIds.contains(json['id'])) continue;

        batch.insert(
          _db.localCajas,
          LocalCajasCompanion.insert(
            id: json['id'] as String,
            montoInicial: json['monto_inicial'] as int,
            montoFinalDeclarado: Value(json['monto_final_declarado'] as int?),
            montoFinalCalculado: Value(json['monto_final_calculado'] as int?),
            diferencia: Value(json['diferencia'] as int?),
            estado: json['estado'] as String,
            deviceId: json['device_id'] as String? ?? '',
            nombreDispositivo: Value(json['nombre_dispositivo'] as String?),
            ocurridaEn: DateTime.parse(json['created_at'] as String),
            cerradaEn: Value(
              json['cerrada_at'] == null ? null : DateTime.parse(json['cerrada_at'] as String),
            ),
            pendienteSync: const Value(false),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> _pullCajaMovimientos(List movimientos) async {
    final pendientesIds = (await (_db.select(_db.localCajaMovimientos)
              ..where((t) => t.pendienteSync.equals(true)))
            .get())
        .map((m) => m.id)
        .toSet();

    await _db.batch((batch) {
      for (final fila in movimientos) {
        final json = fila as Map<String, dynamic>;
        if (pendientesIds.contains(json['id'])) continue;

        // Solo espejamos ingreso/retiro manuales acá — los movimientos de
        // tipo 'venta' ya están representados por LocalVentas, no hace
        // falta duplicarlos.
        if (json['tipo'] == 'venta') continue;

        batch.insert(
          _db.localCajaMovimientos,
          LocalCajaMovimientosCompanion.insert(
            id: json['id'] as String,
            cajaId: json['caja_id'] as String,
            tipo: json['tipo'] as String,
            monto: json['monto'] as int,
            nota: json['nota'] as String? ?? '',
            ocurridaEn: DateTime.parse(json['created_at'] as String),
            pendienteSync: const Value(false),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> _pullVentas(List ventas) async {
    final pendientesIds = (await (_db.select(_db.localVentas)
              ..where((t) => t.pendienteSync.equals(true)))
            .get())
        .map((v) => v.id)
        .toSet();

    await _db.batch((batch) {
      for (final fila in ventas) {
        final json = fila as Map<String, dynamic>;
        if (pendientesIds.contains(json['id'])) continue;

        batch.insert(
          _db.localVentas,
          LocalVentasCompanion.insert(
            id: json['id'] as String,
            numero: Value(json['numero'] as int?),
            clienteId: Value(json['cliente_id'] as String?),
            formaPago: json['forma_pago'] as String,
            tipoComprobante: json['tipo_comprobante'] as String,
            subtotal: json['subtotal'] as int,
            descuento: json['descuento'] as int,
            total: json['total'] as int,
            deviceId: Value(json['device_id'] as String?),
            ocurridaEn: DateTime.parse(json['created_at'] as String),
            pendienteSync: const Value(false),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> _pullVentaItems(List items) async {
    await _db.batch((batch) {
      for (final fila in items) {
        final json = fila as Map<String, dynamic>;

        batch.insert(
          _db.localVentaItems,
          LocalVentaItemsCompanion.insert(
            id: json['id'] as String,
            ventaId: json['venta_id'] as String,
            articuloId: json['articulo_id'] as String,
            cantidad: json['cantidad'] as int,
            precioUnitario: json['precio_unitario'] as int,
            subtotal: json['subtotal'] as int,
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<String?> _leerUltimoPull() async {
    final fila = await (_db.select(_db.syncMeta)..where((t) => t.clave.equals(_lastPullKey)))
        .getSingleOrNull();
    return fila?.valor;
  }

  Future<void> _guardarUltimoPull(String serverTime) async {
    await _db.into(_db.syncMeta).insertOnConflictUpdate(
          SyncMetaCompanion.insert(clave: _lastPullKey, valor: serverTime),
        );
  }
}

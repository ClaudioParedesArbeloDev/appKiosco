import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../core/offline/app_database.dart';
import '../core/offline/offline_queue.dart';
import '../models/caja_model.dart';
import '../models/caja_movimiento_model.dart';
import '../models/paginated_response.dart';
import 'caja_api_service.dart';
import 'secure_storage_service.dart';

class CajaRepository {
  CajaRepository(this._api, this._storage, this._db);

  final CajaApiService _api;
  final SecureStorageService _storage;
  final AppDatabase _db;

  /// Null cuando no hay ninguna caja abierta EN ESTE dispositivo — cada
  /// mostrador/PC tiene la suya, independiente de las demás.
  Future<CajaModel?> actual() async {
    Response? response;
    final deviceId = await _storage.getOrCreateDeviceId();
    try {
      response = await _api.actual(deviceId);
      return CajaModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      if (esErrorDeConexion(e)) return _actualOffline(deviceId);
      debugPrint(
        'CajaRepository.actual() falló (DioException): status=${e.response?.statusCode} '
        'body=${e.response?.data} error=${e.message}',
      );
      rethrow;
    } catch (e, stack) {
      // No fue un error de red/HTTP — la respuesta llegó pero algo falló
      // parseándola (CajaModel.fromJson). Mostramos el body crudo para ver
      // qué forma tiene lo que realmente mandó el backend.
      debugPrint('CajaRepository.actual() falló parseando la respuesta: $e');
      debugPrint('Body crudo recibido: ${response?.data}');
      debugPrint('$stack');
      rethrow;
    }
  }

  Future<CajaModel?> _actualOffline(String deviceId) async {
    final fila = await (_db.select(_db.localCajas)
          ..where((t) => t.estado.equals('abierta') & t.deviceId.equals(deviceId)))
        .getSingleOrNull();

    if (fila == null) return null;

    return CajaModel(
      id: fila.id,
      montoInicial: fila.montoInicial,
      montoFinalDeclarado: fila.montoFinalDeclarado,
      montoFinalCalculado: fila.montoFinalCalculado,
      diferencia: fila.diferencia,
      estado: fila.estado,
      cerradaAt: fila.cerradaEn,
      nombreDispositivo: fila.nombreDispositivo,
      // El resumen (ventas/ingresos/retiros acumulados) lo calcula siempre
      // el server sumando `caja_movimientos` reales — no lo recalculamos
      // local porque incluiría solo lo que pasó offline, no toda la caja.
      resumen: null,
      pendienteSync: fila.pendienteSync,
    );
  }

  Future<PaginatedResponse<CajaModel>> historial({String? desde, String? hasta}) async {
    final response = await _api.historial(desde: desde, hasta: hasta);
    return PaginatedResponse.fromJson(response.data, CajaModel.fromJson);
  }

  Future<CajaModel> abrir(int montoInicial) async {
    final deviceId = await _storage.getOrCreateDeviceId();
    final nombreDispositivo = await _storage.getDeviceNombre();
    try {
      final response = await _api.abrir(
        montoInicial: montoInicial,
        deviceId: deviceId,
        nombreDispositivo: nombreDispositivo,
      );
      return CajaModel.fromJson(response.data);
    } catch (e) {
      if (!esErrorDeConexion(e)) rethrow;
      return _abrirOffline(montoInicial, deviceId, nombreDispositivo);
    }
  }

  Future<CajaModel> _abrirOffline(
    int montoInicial,
    String deviceId,
    String? nombreDispositivo,
  ) async {
    final id = const Uuid().v4();
    final ocurridaEn = DateTime.now();

    await _db.into(_db.localCajas).insert(
          LocalCajasCompanion.insert(
            id: id,
            montoInicial: montoInicial,
            estado: 'abierta',
            deviceId: deviceId,
            nombreDispositivo: Value(nombreDispositivo),
            ocurridaEn: ocurridaEn,
            pendienteSync: const Value(true),
          ),
        );

    await encolarOperacion(
      _db,
      tipoOperacion: 'abrir_caja',
      entidadLocalId: id,
      payload: {
        'id': id,
        'monto_inicial': montoInicial,
        'device_id': deviceId,
        'nombre_dispositivo': ?nombreDispositivo,
        'ocurrida_en': ocurridaEn.toIso8601String(),
      },
      ocurridaEn: ocurridaEn,
    );

    return CajaModel(
      id: id,
      montoInicial: montoInicial,
      estado: 'abierta',
      nombreDispositivo: nombreDispositivo,
      pendienteSync: true,
    );
  }

  Future<CajaMovimientoModel> registrarMovimiento({
    required String tipo,
    required int monto,
    required String nota,
  }) async {
    final deviceId = await _storage.getOrCreateDeviceId();
    try {
      final response = await _api.registrarMovimiento(
        tipo: tipo,
        monto: monto,
        nota: nota,
        deviceId: deviceId,
      );
      return CajaMovimientoModel.fromJson(response.data);
    } catch (e) {
      if (!esErrorDeConexion(e)) rethrow;
      return _registrarMovimientoOffline(tipo: tipo, monto: monto, nota: nota, deviceId: deviceId);
    }
  }

  Future<CajaMovimientoModel> _registrarMovimientoOffline({
    required String tipo,
    required int monto,
    required String nota,
    required String deviceId,
  }) async {
    final id = const Uuid().v4();
    final ocurridaEn = DateTime.now();
    final montoConSigno = tipo == 'retiro' ? -monto : monto;

    final cajaLocal = await (_db.select(_db.localCajas)
          ..where((t) => t.estado.equals('abierta') & t.deviceId.equals(deviceId)))
        .getSingleOrNull();

    if (cajaLocal != null) {
      await _db.into(_db.localCajaMovimientos).insert(
            LocalCajaMovimientosCompanion.insert(
              id: id,
              cajaId: cajaLocal.id,
              tipo: tipo,
              monto: montoConSigno,
              nota: nota,
              ocurridaEn: ocurridaEn,
              pendienteSync: const Value(true),
            ),
          );
    }

    await encolarOperacion(
      _db,
      tipoOperacion: 'registrar_movimiento',
      entidadLocalId: id,
      payload: {
        'id': id,
        'tipo': tipo,
        'monto': monto,
        'nota': nota,
        'device_id': deviceId,
        'ocurrida_en': ocurridaEn.toIso8601String(),
      },
      ocurridaEn: ocurridaEn,
    );

    return CajaMovimientoModel(
      id: id,
      tipo: tipo,
      monto: montoConSigno,
      nota: nota,
      createdAt: ocurridaEn,
    );
  }

  Future<CajaModel> cerrar(int montoFinalDeclarado) async {
    final deviceId = await _storage.getOrCreateDeviceId();
    try {
      final response = await _api.cerrar(montoFinalDeclarado, deviceId);
      return CajaModel.fromJson(response.data);
    } catch (e) {
      if (!esErrorDeConexion(e)) rethrow;
      return _cerrarOffline(montoFinalDeclarado, deviceId);
    }
  }

  Future<CajaModel> _cerrarOffline(int montoFinalDeclarado, String deviceId) async {
    final cajaLocal = await (_db.select(_db.localCajas)
          ..where((t) => t.estado.equals('abierta') & t.deviceId.equals(deviceId)))
        .getSingleOrNull();

    final ocurridaEn = DateTime.now();

    if (cajaLocal != null) {
      await (_db.update(_db.localCajas)..where((t) => t.id.equals(cajaLocal.id))).write(
        LocalCajasCompanion(
          estado: const Value('cerrada'),
          montoFinalDeclarado: Value(montoFinalDeclarado),
          cerradaEn: Value(ocurridaEn),
          pendienteSync: const Value(true),
        ),
      );
    }

    await encolarOperacion(
      _db,
      tipoOperacion: 'cerrar_caja',
      entidadLocalId: cajaLocal?.id ?? const Uuid().v4(),
      payload: {
        'monto_final_declarado': montoFinalDeclarado,
        'device_id': deviceId,
        'ocurrida_en': ocurridaEn.toIso8601String(),
      },
      ocurridaEn: ocurridaEn,
    );

    // El monto calculado y la diferencia dependen de TODOS los movimientos
    // reales de la caja (algunos pudieron haber pasado online antes de
    // cortarse la conexión) — no los inventamos acá, quedan pendientes
    // hasta que el server los calcule al sincronizar el cierre.
    return CajaModel(
      id: cajaLocal?.id ?? '',
      montoInicial: cajaLocal?.montoInicial ?? 0,
      montoFinalDeclarado: montoFinalDeclarado,
      estado: 'cerrada',
      cerradaAt: ocurridaEn,
      nombreDispositivo: cajaLocal?.nombreDispositivo,
      pendienteSync: true,
    );
  }
}

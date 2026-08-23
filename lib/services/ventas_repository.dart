import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../core/offline/app_database.dart';
import '../core/offline/offline_queue.dart';
import '../models/cart_item.dart';
import '../models/estadistica_mensual_model.dart';
import '../models/paginated_response.dart';
import '../models/producto_mas_vendido_model.dart';
import '../models/venta_estadisticas_model.dart';
import '../models/venta_model.dart';
import 'secure_storage_service.dart';
import 'ventas_api_service.dart';

class VentasRepository {
  VentasRepository(this._api, this._storage, this._db);

  final VentasApiService _api;
  final SecureStorageService _storage;
  final AppDatabase _db;

  Future<VentaModel> crear({
    required List<CartItem> items,
    required String formaPago,
    String? clienteId,
  }) async {
    // El backend usa esto para cargar el movimiento a LA caja de este
    // dispositivo (cada mostrador/PC tiene la suya) — ver CajaController.
    final deviceId = await _storage.getOrCreateDeviceId();

    final payload = {
      // Sin facturación electrónica AFIP todavía: todas las ventas salen
      // como comprobante interno ("X"), no factura fiscal A/B/C.
      'tipo_comprobante': 'X',
      'forma_pago': formaPago,
      'device_id': deviceId,
      'cliente_id': ?clienteId,
      'items': items
          .map((item) => {
                'articulo_id': item.articulo.id,
                'cantidad': item.cantidad,
              })
          .toList(),
    };

    try {
      final response = await _api.crear(payload);
      return VentaModel.fromJson(response.data);
    } catch (e) {
      if (!esErrorDeConexion(e)) rethrow;
      return _crearOffline(
        items: items,
        formaPago: formaPago,
        clienteId: clienteId,
        deviceId: deviceId,
        payload: payload,
      );
    }
  }

  /// Sin conexión: se calcula el total de forma optimista con el mismo
  /// criterio que usaría el server (precio vigente de cada item × cantidad,
  /// menos el % de descuento del cliente si lo tenemos cacheado), se
  /// guarda local y se encola para crearse de verdad al reconectar — recién
  /// ahí el server recalcula todo desde la base real y asigna el número de
  /// venta definitivo (nunca se genera numeración secuencial offline, para
  /// no arriesgar colisión entre dos dispositivos).
  Future<VentaModel> _crearOffline({
    required List<CartItem> items,
    required String formaPago,
    required String? clienteId,
    required String deviceId,
    required Map<String, dynamic> payload,
  }) async {
    final id = const Uuid().v4();
    final ocurridaEn = DateTime.now();

    final subtotal = items.fold<int>(0, (acc, item) => acc + item.subtotal);

    var porcentajeDescuento = 0;
    if (clienteId != null) {
      final cliente = await (_db.select(_db.localClientes)..where((t) => t.id.equals(clienteId)))
          .getSingleOrNull();
      porcentajeDescuento = cliente?.porcentajeDescuento ?? 0;
    }
    final descuento = (subtotal * porcentajeDescuento / 100).round();
    final total = (subtotal - descuento).clamp(0, subtotal);

    await _db.into(_db.localVentas).insert(
          LocalVentasCompanion.insert(
            id: id,
            clienteId: Value(clienteId),
            formaPago: formaPago,
            tipoComprobante: 'X',
            subtotal: subtotal,
            descuento: descuento,
            total: total,
            deviceId: Value(deviceId),
            ocurridaEn: ocurridaEn,
            pendienteSync: const Value(true),
          ),
        );

    for (final item in items) {
      await _db.into(_db.localVentaItems).insert(
            LocalVentaItemsCompanion.insert(
              id: const Uuid().v4(),
              ventaId: id,
              articuloId: item.articulo.id,
              cantidad: item.cantidad,
              precioUnitario: item.articulo.precioVigente,
              subtotal: item.subtotal,
            ),
          );
    }

    await encolarOperacion(
      _db,
      tipoOperacion: 'crear_venta',
      entidadLocalId: id,
      payload: {...payload, 'id': id, 'ocurrida_en': ocurridaEn.toIso8601String()},
      ocurridaEn: ocurridaEn,
    );

    return VentaModel(
      id: id,
      numero: null,
      total: total,
      formaPago: formaPago,
      tipoComprobante: 'X',
      estado: 'completada',
      createdAt: ocurridaEn,
      subtotal: subtotal,
      descuento: descuento,
      pendienteSync: true,
    );
  }

  Future<PaginatedResponse<VentaModel>> listar({String? estado, int page = 1}) async {
    final response = await _api.listar(estado: estado, page: page);
    return PaginatedResponse.fromJson(response.data, VentaModel.fromJson);
  }

  Future<VentaModel> ver(String id) async {
    final response = await _api.ver(id);
    return VentaModel.fromJson(response.data);
  }

  Future<VentaModel> anular(String id, String motivo) async {
    final response = await _api.anular(id, motivo);
    return VentaModel.fromJson(response.data);
  }

  Future<VentasEstadisticasModel> estadisticas() async {
    final response = await _api.estadisticas();
    return VentasEstadisticasModel.fromJson(response.data);
  }

  Future<List<ProductoMasVendidoModel>> productosMasVendidos(String periodo) async {
    final response = await _api.productosMasVendidos(periodo);
    final lista = response.data['productos'] as List;
    return lista.map((p) => ProductoMasVendidoModel.fromJson(p)).toList();
  }

  Future<List<EstadisticaMensualModel>> estadisticasMensuales() async {
    final response = await _api.estadisticasMensuales();
    final lista = response.data['meses'] as List;
    return lista.map((m) => EstadisticaMensualModel.fromJson(m)).toList();
  }
}

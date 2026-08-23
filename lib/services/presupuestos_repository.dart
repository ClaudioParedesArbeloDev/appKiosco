import '../models/item_cantidad_draft.dart';
import '../models/paginated_response.dart';
import '../models/presupuesto_model.dart';
import '../models/venta_model.dart';
import 'presupuestos_api_service.dart';
import 'secure_storage_service.dart';

class PresupuestosRepository {
  PresupuestosRepository(this._api, this._storage);

  final PresupuestosApiService _api;
  final SecureStorageService _storage;

  Future<PaginatedResponse<PresupuestoModel>> listar({int page = 1}) async {
    final response = await _api.listar(page: page);
    return PaginatedResponse.fromJson(response.data, PresupuestoModel.fromJson);
  }

  Future<PresupuestoModel> ver(String id) async {
    final response = await _api.ver(id);
    return PresupuestoModel.fromJson(response.data);
  }

  Future<PresupuestoModel> crear({
    String? clienteId,
    required List<ItemCantidadDraft> items,
  }) async {
    final response = await _api.crear({
      'cliente_id': ?clienteId,
      'items': items
          .map((item) => {'articulo_id': item.articulo.id, 'cantidad': item.cantidad})
          .toList(),
    });

    return PresupuestoModel.fromJson(response.data);
  }

  Future<VentaModel> convertirAVenta(
    String id, {
    required String tipoComprobante,
    required String formaPago,
  }) async {
    final deviceId = await _storage.getOrCreateDeviceId();

    final response = await _api.convertirAVenta(id, {
      'tipo_comprobante': tipoComprobante,
      'forma_pago': formaPago,
      'device_id': deviceId,
    });

    return VentaModel.fromJson(response.data);
  }

  Future<PresupuestoModel> anular(String id) async {
    final response = await _api.anular(id);
    return PresupuestoModel.fromJson(response.data);
  }
}

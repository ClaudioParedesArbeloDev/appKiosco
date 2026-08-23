import '../models/item_cantidad_draft.dart';
import '../models/paginated_response.dart';
import '../models/remito_model.dart';
import '../models/venta_model.dart';
import 'remitos_api_service.dart';
import 'secure_storage_service.dart';

class RemitosRepository {
  RemitosRepository(this._api, this._storage);

  final RemitosApiService _api;
  final SecureStorageService _storage;

  Future<PaginatedResponse<RemitoModel>> listar({int page = 1}) async {
    final response = await _api.listar(page: page);
    return PaginatedResponse.fromJson(response.data, RemitoModel.fromJson);
  }

  Future<RemitoModel> ver(String id) async {
    final response = await _api.ver(id);
    return RemitoModel.fromJson(response.data);
  }

  Future<RemitoModel> crear({
    String? clienteId,
    required List<ItemCantidadDraft> items,
  }) async {
    final response = await _api.crear({
      'cliente_id': ?clienteId,
      'items': items
          .map((item) => {'articulo_id': item.articulo.id, 'cantidad': item.cantidad})
          .toList(),
    });

    return RemitoModel.fromJson(response.data);
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

  Future<RemitoModel> anular(String id, String motivo) async {
    final response = await _api.anular(id, motivo);
    return RemitoModel.fromJson(response.data);
  }
}

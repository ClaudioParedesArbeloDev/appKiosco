import '../models/compra_item_draft.dart';
import '../models/compra_model.dart';
import '../models/paginated_response.dart';
import 'compras_api_service.dart';
import 'secure_storage_service.dart';

class ComprasRepository {
  ComprasRepository(this._api, this._storage);

  final ComprasApiService _api;
  final SecureStorageService _storage;

  Future<PaginatedResponse<CompraModel>> listar({int page = 1}) async {
    final response = await _api.listar(page: page);
    return PaginatedResponse.fromJson(response.data, CompraModel.fromJson);
  }

  Future<CompraModel> ver(String id) async {
    final response = await _api.ver(id);
    return CompraModel.fromJson(response.data);
  }

  Future<CompraModel> crear({
    required String proveedorId,
    required String formaPago,
    required List<CompraItemDraft> items,
    bool actualizaCosto = true,
    String? numeroFactura,
  }) async {
    final deviceId = await _storage.getOrCreateDeviceId();

    final response = await _api.crear({
      'proveedor_id': proveedorId,
      'forma_pago': formaPago,
      'actualiza_costo': actualizaCosto,
      if (numeroFactura != null && numeroFactura.isNotEmpty) 'numero_factura': numeroFactura,
      'device_id': deviceId,
      'items': items
          .map((item) => {
                'articulo_id': item.articulo.id,
                'cantidad': item.cantidad,
                'precio_unitario': item.precioUnitario,
              })
          .toList(),
    });

    return CompraModel.fromJson(response.data);
  }

  Future<CompraModel> anular(String id, String motivo) async {
    final response = await _api.anular(id, motivo);
    return CompraModel.fromJson(response.data);
  }
}

import '../models/nota_credito_model.dart';
import '../models/paginated_response.dart';
import 'notas_credito_api_service.dart';

class NotaCreditoItemDraft {
  const NotaCreditoItemDraft({required this.ventaItemId, required this.cantidad});

  final String ventaItemId;
  final int cantidad;
}

class NotasCreditoRepository {
  NotasCreditoRepository(this._api);

  final NotasCreditoApiService _api;

  Future<PaginatedResponse<NotaCreditoModel>> listar({int page = 1}) async {
    final response = await _api.listar(page: page);
    return PaginatedResponse.fromJson(response.data, NotaCreditoModel.fromJson);
  }

  Future<NotaCreditoModel> ver(String id) async {
    final response = await _api.ver(id);
    return NotaCreditoModel.fromJson(response.data);
  }

  Future<List<NotaCreditoModel>> porVenta(String ventaId) async {
    final response = await _api.porVenta(ventaId);
    return (response.data as List).map((e) => NotaCreditoModel.fromJson(e)).toList();
  }

  Future<NotaCreditoModel> crear(
    String ventaId, {
    required String motivo,
    required List<NotaCreditoItemDraft> items,
  }) async {
    final response = await _api.crear(ventaId, {
      'motivo': motivo,
      'items': items
          .map((item) => {'venta_item_id': item.ventaItemId, 'cantidad': item.cantidad})
          .toList(),
    });

    return NotaCreditoModel.fromJson(response.data);
  }
}

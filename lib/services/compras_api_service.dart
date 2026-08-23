import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class ComprasApiService {
  ComprasApiService(this._client);

  final ApiClient _client;

  Future<Response> listar({int page = 1}) {
    return _client.dio.get(ApiEndpoints.compras, queryParameters: {'page': page});
  }

  Future<Response> ver(String id) => _client.dio.get(ApiEndpoints.compra(id));

  Future<Response> crear(Map<String, dynamic> data) =>
      _client.dio.post(ApiEndpoints.compras, data: data);

  Future<Response> anular(String id, String motivo) {
    return _client.dio.post(ApiEndpoints.compraAnular(id), data: {'motivo': motivo});
  }
}

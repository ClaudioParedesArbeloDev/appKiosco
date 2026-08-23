import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class RemitosApiService {
  RemitosApiService(this._client);

  final ApiClient _client;

  Future<Response> listar({int page = 1}) {
    return _client.dio.get(ApiEndpoints.remitos, queryParameters: {'page': page});
  }

  Future<Response> ver(String id) => _client.dio.get(ApiEndpoints.remito(id));

  Future<Response> crear(Map<String, dynamic> data) =>
      _client.dio.post(ApiEndpoints.remitos, data: data);

  Future<Response> convertirAVenta(String id, Map<String, dynamic> data) =>
      _client.dio.post(ApiEndpoints.remitoConvertirVenta(id), data: data);

  Future<Response> anular(String id, String motivo) {
    return _client.dio.post(ApiEndpoints.remitoAnular(id), data: {'motivo': motivo});
  }
}

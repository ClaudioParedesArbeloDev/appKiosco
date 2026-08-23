import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class NotasCreditoApiService {
  NotasCreditoApiService(this._client);

  final ApiClient _client;

  Future<Response> listar({int page = 1}) {
    return _client.dio.get(ApiEndpoints.notasCredito, queryParameters: {'page': page});
  }

  Future<Response> ver(String id) => _client.dio.get(ApiEndpoints.notaCredito(id));

  Future<Response> porVenta(String ventaId) =>
      _client.dio.get(ApiEndpoints.ventaNotasCredito(ventaId));

  Future<Response> crear(String ventaId, Map<String, dynamic> data) =>
      _client.dio.post(ApiEndpoints.ventaNotasCredito(ventaId), data: data);
}

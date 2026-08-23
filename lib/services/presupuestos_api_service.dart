import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class PresupuestosApiService {
  PresupuestosApiService(this._client);

  final ApiClient _client;

  Future<Response> listar({int page = 1}) {
    return _client.dio.get(ApiEndpoints.presupuestos, queryParameters: {'page': page});
  }

  Future<Response> ver(String id) => _client.dio.get(ApiEndpoints.presupuesto(id));

  Future<Response> crear(Map<String, dynamic> data) =>
      _client.dio.post(ApiEndpoints.presupuestos, data: data);

  Future<Response> convertirAVenta(String id, Map<String, dynamic> data) =>
      _client.dio.post(ApiEndpoints.presupuestoConvertirVenta(id), data: data);

  Future<Response> anular(String id) => _client.dio.post(ApiEndpoints.presupuestoAnular(id));
}

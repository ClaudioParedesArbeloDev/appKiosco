import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class EmpleadosApiService {
  EmpleadosApiService(this._client);

  final ApiClient _client;

  Future<Response> listar() => _client.dio.get(ApiEndpoints.empleados);

  Future<Response> crear(Map<String, dynamic> data) {
    return _client.dio.post(ApiEndpoints.empleados, data: data);
  }

  Future<Response> actualizar(String id, Map<String, dynamic> data) {
    return _client.dio.put(ApiEndpoints.empleado(id), data: data);
  }

  Future<Response> comisiones({DateTime? desde, DateTime? hasta}) {
    return _client.dio.get(ApiEndpoints.empleadosComisiones, queryParameters: {
      if (desde != null) 'desde': desde.toIso8601String().substring(0, 10),
      if (hasta != null) 'hasta': hasta.toIso8601String().substring(0, 10),
    });
  }
}

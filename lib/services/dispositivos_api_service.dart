import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class DispositivosApiService {
  DispositivosApiService(this._client);

  final ApiClient _client;

  Future<Response> listar() => _client.dio.get(ApiEndpoints.dispositivos);

  Future<Response> desactivar(String id) =>
      _client.dio.post(ApiEndpoints.dispositivoDesactivar(id));

  Future<Response> reactivar(String id) =>
      _client.dio.post(ApiEndpoints.dispositivoReactivar(id));
}

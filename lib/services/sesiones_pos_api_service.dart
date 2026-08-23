import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class SesionesPosApiService {
  SesionesPosApiService(this._client);

  final ApiClient _client;

  Future<Response> crear() => _client.dio.post(ApiEndpoints.sesionesPos);

  Future<Response> parear(String pairingToken) {
    return _client.dio.post(ApiEndpoints.sesionesPosParear, data: {
      'pairing_token': pairingToken,
    });
  }

  Future<Response> scan(String sesionId, String codigo) {
    return _client.dio.post(ApiEndpoints.sesionPosScan(sesionId), data: {
      'codigo': codigo,
    });
  }

  Future<Response> eliminar(String sesionId) =>
      _client.dio.delete(ApiEndpoints.sesionPos(sesionId));
}

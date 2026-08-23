import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class CajaApiService {
  CajaApiService(this._client);

  final ApiClient _client;

  Future<Response> actual(String deviceId) {
    return _client.dio.get(ApiEndpoints.cajaActual, queryParameters: {'device_id': deviceId});
  }

  Future<Response> historial({String? desde, String? hasta}) {
    return _client.dio.get(ApiEndpoints.cajaHistorial, queryParameters: {
      'desde': ?desde,
      'hasta': ?hasta,
    });
  }

  Future<Response> abrir({
    required int montoInicial,
    required String deviceId,
    String? nombreDispositivo,
  }) {
    return _client.dio.post(ApiEndpoints.cajaAbrir, data: {
      'monto_inicial': montoInicial,
      'device_id': deviceId,
      'nombre_dispositivo': nombreDispositivo,
    });
  }

  Future<Response> registrarMovimiento({
    required String tipo,
    required int monto,
    required String nota,
    required String deviceId,
  }) {
    return _client.dio.post(ApiEndpoints.cajaMovimiento, data: {
      'tipo': tipo,
      'monto': monto,
      'nota': nota,
      'device_id': deviceId,
    });
  }

  Future<Response> cerrar(int montoFinalDeclarado, String deviceId) {
    return _client.dio.post(ApiEndpoints.cajaCerrar, data: {
      'monto_final_declarado': montoFinalDeclarado,
      'device_id': deviceId,
    });
  }
}

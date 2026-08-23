import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class MercadoPagoApiService {
  MercadoPagoApiService(this._client);

  final ApiClient _client;

  Future<Response> connect() => _client.dio.post(ApiEndpoints.mercadoPagoConnect);

  Future<Response> status() => _client.dio.get(ApiEndpoints.mercadoPagoStatus);

  Future<Response> disconnect() => _client.dio.post(ApiEndpoints.mercadoPagoDisconnect);

  Future<Response> devices() => _client.dio.get(ApiEndpoints.mercadoPagoDevices);

  Future<Response> crearPaymentIntent({required String deviceId, required int montoCentavos}) {
    return _client.dio.post(ApiEndpoints.mercadoPagoPaymentIntent, data: {
      'device_id': deviceId,
      'monto': montoCentavos,
    });
  }

  Future<Response> estadoPaymentIntent(String paymentIntentId) {
    return _client.dio.get(ApiEndpoints.mercadoPagoPaymentIntentStatus(paymentIntentId));
  }
}

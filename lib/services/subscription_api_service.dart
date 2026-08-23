import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class SubscriptionApiService {
  SubscriptionApiService(this._client);

  final ApiClient _client;

  Future<Response> show() => _client.dio.get(ApiEndpoints.subscription);

  Future<Response> checkout() => _client.dio.post(ApiEndpoints.subscriptionCheckout);
}

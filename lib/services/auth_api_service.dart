import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../models/tenant_registration_data.dart';

class AuthApiService {
  AuthApiService(this._client);

  final ApiClient _client;

  Future<Response> login(
    String email,
    String password,
    String deviceName, {
    String? producto,
    String? tenantId,
  }) {
    return _client.dio.post(ApiEndpoints.login, data: {
      'email': email,
      'password': password,
      'device_name': deviceName,
      'producto': ?producto,
      'tenant_id': ?tenantId,
    });
  }

  Future<Response> register(TenantRegistrationData data) {
    return _client.dio.post(ApiEndpoints.register, data: data.toJson());
  }

  Future<Response> loginWithGoogleIdToken(
    String idToken, {
    String? producto,
    String? tenantId,
  }) {
    return _client.dio.post(ApiEndpoints.googleLogin, data: {
      'id_token': idToken,
      'producto': ?producto,
      'tenant_id': ?tenantId,
    });
  }

  Future<Response> selectTenantForGoogle({
    required String ticket,
    required String tenantId,
    required String deviceName,
  }) {
    return _client.dio.post(ApiEndpoints.googleSelectTenant, data: {
      'ticket': ticket,
      'tenant_id': tenantId,
      'device_name': deviceName,
    });
  }

  Future<Response> logout() => _client.dio.post(ApiEndpoints.logout);

  Future<Response> forgotPassword(String email) {
    return _client.dio.post(ApiEndpoints.forgotPassword, data: {'email': email});
  }

  Future<Response> me() => _client.dio.get(ApiEndpoints.me);

  Future<Response> actualizarPerfil({required String name}) {
    return _client.dio.put(ApiEndpoints.me, data: {'name': name});
  }
}

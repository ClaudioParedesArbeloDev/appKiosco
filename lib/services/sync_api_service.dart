import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class SyncApiService {
  SyncApiService(this._client);

  final ApiClient _client;

  Future<Response> pull({String? since}) {
    return _client.dio.get(
      ApiEndpoints.syncPull,
      queryParameters: {'since': ?since},
    );
  }

  Future<Response> push({
    required String deviceId,
    required Map<String, List<Map<String, dynamic>>> changes,
  }) {
    return _client.dio.post(ApiEndpoints.syncPush, data: {
      'device_id': deviceId,
      'changes': changes,
    });
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/remitos_api_service.dart';
import '../services/remitos_repository.dart';
import '../services/secure_storage_service.dart';
import 'auth_providers.dart';

final remitosRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return RemitosRepository(RemitosApiService(client), SecureStorageService());
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/compras_api_service.dart';
import '../services/compras_repository.dart';
import '../services/secure_storage_service.dart';
import 'auth_providers.dart';

final comprasRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return ComprasRepository(ComprasApiService(client), SecureStorageService());
});

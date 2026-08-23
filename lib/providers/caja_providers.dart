import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/caja_api_service.dart';
import '../services/caja_repository.dart';
import '../services/secure_storage_service.dart';
import 'auth_providers.dart';
import 'sync_providers.dart';

final cajaRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return CajaRepository(
    CajaApiService(client),
    SecureStorageService(),
    ref.watch(appDatabaseProvider),
  );
});

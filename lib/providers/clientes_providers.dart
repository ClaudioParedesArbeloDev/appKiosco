import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../providers/sync_providers.dart';
import '../services/clientes_api_service.dart';
import '../services/clientes_repository.dart';
import '../services/secure_storage_service.dart';

final clientesRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return ClientesRepository(
    ClientesApiService(client),
    SecureStorageService(),
    ref.watch(appDatabaseProvider),
  );
});

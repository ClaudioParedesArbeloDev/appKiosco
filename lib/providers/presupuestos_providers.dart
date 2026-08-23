import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/presupuestos_api_service.dart';
import '../services/presupuestos_repository.dart';
import '../services/secure_storage_service.dart';
import 'auth_providers.dart';

final presupuestosRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return PresupuestosRepository(PresupuestosApiService(client), SecureStorageService());
});

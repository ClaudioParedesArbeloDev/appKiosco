import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/proveedores_api_service.dart';
import '../services/proveedores_repository.dart';
import '../services/secure_storage_service.dart';
import 'auth_providers.dart';

final proveedoresRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return ProveedoresRepository(ProveedoresApiService(client), SecureStorageService());
});

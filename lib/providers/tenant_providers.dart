import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_providers.dart';
import '../services/tenant_api_service.dart';
import '../services/tenant_repository.dart';

final tenantRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return TenantRepository(TenantApiService(client));
});

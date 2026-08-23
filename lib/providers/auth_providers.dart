import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../models/pending_tenant_selection.dart';
import '../services/auth_api_service.dart';
import '../services/auth_repository.dart';
import '../services/secure_storage_service.dart';

final apiClientProvider = Provider((ref) => ApiClient());

final authRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return AuthRepository(AuthApiService(client), client, SecureStorageService());
});

/// Negocios entre los que hay que elegir cuando un login (password o
/// Google) devuelve `requires_tenant_selection` — separado del estado de
/// auth para no pisar la sesión actual ni disparar el canal de error.
class PendingTenantSelectionNotifier extends Notifier<PendingTenantSelection?> {
  @override
  PendingTenantSelection? build() => null;

  void set(PendingTenantSelection? value) => state = value;
}

final pendingTenantSelectionProvider =
    NotifierProvider<PendingTenantSelectionNotifier, PendingTenantSelection?>(
  PendingTenantSelectionNotifier.new,
);

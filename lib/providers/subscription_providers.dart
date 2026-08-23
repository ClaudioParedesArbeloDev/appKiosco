import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/subscription_api_service.dart';
import '../services/subscription_repository.dart';
import 'auth_providers.dart';

final subscriptionRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return SubscriptionRepository(SubscriptionApiService(client));
});

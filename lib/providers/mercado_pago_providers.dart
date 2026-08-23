import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_providers.dart';
import '../services/mercado_pago_api_service.dart';
import '../services/mercado_pago_repository.dart';

final mercadoPagoRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return MercadoPagoRepository(MercadoPagoApiService(client));
});

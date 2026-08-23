import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/notas_credito_api_service.dart';
import '../services/notas_credito_repository.dart';
import 'auth_providers.dart';

final notasCreditoRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return NotasCreditoRepository(NotasCreditoApiService(client));
});

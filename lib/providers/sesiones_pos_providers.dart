import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../services/sesiones_pos_api_service.dart';
import '../services/sesiones_pos_repository.dart';

final sesionesPosRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return SesionesPosRepository(SesionesPosApiService(client));
});

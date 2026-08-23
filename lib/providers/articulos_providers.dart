import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../services/articulos_api_service.dart';
import '../services/articulos_repository.dart';
import 'sync_providers.dart';

final articulosRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return ArticulosRepository(ArticulosApiService(client), ref.watch(appDatabaseProvider));
});

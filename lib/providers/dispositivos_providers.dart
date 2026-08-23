import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dispositivo_model.dart';
import '../services/dispositivos_api_service.dart';
import '../services/dispositivos_repository.dart';
import 'auth_providers.dart';

final dispositivosRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return DispositivosRepository(DispositivosApiService(client));
});

final dispositivosListProvider = FutureProvider<List<DispositivoModel>>((ref) {
  return ref.read(dispositivosRepositoryProvider).listar();
});

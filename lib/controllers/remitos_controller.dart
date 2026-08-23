import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/paginated_response.dart';
import '../models/remito_model.dart';
import '../providers/remitos_providers.dart';

final remitosListProvider = FutureProvider<PaginatedResponse<RemitoModel>>((ref) {
  return ref.read(remitosRepositoryProvider).listar();
});

final remitoDetailProvider = FutureProvider.family<RemitoModel, String>((ref, id) {
  return ref.read(remitosRepositoryProvider).ver(id);
});

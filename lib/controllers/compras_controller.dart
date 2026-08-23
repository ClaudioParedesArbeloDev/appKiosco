import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compra_model.dart';
import '../models/paginated_response.dart';
import '../providers/compras_providers.dart';

final comprasListProvider = FutureProvider<PaginatedResponse<CompraModel>>((ref) {
  return ref.read(comprasRepositoryProvider).listar();
});

final compraDetailProvider = FutureProvider.family<CompraModel, String>((ref, id) {
  return ref.read(comprasRepositoryProvider).ver(id);
});

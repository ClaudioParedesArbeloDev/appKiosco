import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/nota_credito_model.dart';
import '../models/paginated_response.dart';
import '../providers/notas_credito_providers.dart';

final notasCreditoListProvider = FutureProvider<PaginatedResponse<NotaCreditoModel>>((ref) {
  return ref.read(notasCreditoRepositoryProvider).listar();
});

final notasCreditoPorVentaProvider =
    FutureProvider.family<List<NotaCreditoModel>, String>((ref, ventaId) {
  return ref.read(notasCreditoRepositoryProvider).porVenta(ventaId);
});

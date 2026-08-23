import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/paginated_response.dart';
import '../models/presupuesto_model.dart';
import '../providers/presupuestos_providers.dart';

final presupuestosListProvider = FutureProvider<PaginatedResponse<PresupuestoModel>>((ref) {
  return ref.read(presupuestosRepositoryProvider).listar();
});

final presupuestoDetailProvider = FutureProvider.family<PresupuestoModel, String>((ref, id) {
  return ref.read(presupuestosRepositoryProvider).ver(id);
});

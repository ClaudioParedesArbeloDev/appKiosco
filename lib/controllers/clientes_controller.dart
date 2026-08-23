import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cliente_cuenta_corriente_model.dart';
import '../models/cliente_estadisticas_model.dart';
import '../models/cliente_model.dart';
import '../models/paginated_response.dart';
import '../models/venta_model.dart';
import '../providers/clientes_providers.dart';

class ClienteFilters {
  const ClienteFilters({this.search, this.activo});

  final String? search;
  final bool? activo;

  ClienteFilters copyWith({String? search, bool? activo}) {
    return ClienteFilters(
      search: search ?? this.search,
      activo: activo ?? this.activo,
    );
  }
}

class ClienteFiltersNotifier extends Notifier<ClienteFilters> {
  @override
  ClienteFilters build() => const ClienteFilters();

  void update(ClienteFilters filters) => state = filters;
}

final clienteFiltersProvider = NotifierProvider<ClienteFiltersNotifier, ClienteFilters>(
  ClienteFiltersNotifier.new,
);

final clientesListProvider = FutureProvider<PaginatedResponse<ClienteModel>>((ref) {
  final filters = ref.watch(clienteFiltersProvider);
  return ref.read(clientesRepositoryProvider).listar(
        search: filters.search,
        activo: filters.activo,
      );
});

final clienteDetailProvider = FutureProvider.family<ClienteModel, String>((ref, id) {
  return ref.read(clientesRepositoryProvider).ver(id);
});

final clienteVentasProvider = FutureProvider.family<PaginatedResponse<VentaModel>, String>(
  (ref, id) {
    return ref.read(clientesRepositoryProvider).ventas(id);
  },
);

final clienteEstadisticasProvider = FutureProvider.family<ClienteEstadisticasModel, String>(
  (ref, id) {
    return ref.read(clientesRepositoryProvider).estadisticas(id);
  },
);

final clienteCuentaCorrienteProvider =
    FutureProvider.family<ClienteCuentaCorrienteModel, String>((ref, id) {
  return ref.read(clientesRepositoryProvider).cuentaCorriente(id);
});

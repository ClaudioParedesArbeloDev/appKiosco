import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/articulo_model.dart';
import '../models/movimiento_stock_model.dart';
import '../models/paginated_response.dart';
import '../providers/articulos_providers.dart';

class ArticuloFilters {
  const ArticuloFilters({this.search, this.rubro, this.activo});

  final String? search;
  final String? rubro;
  final bool? activo;

  ArticuloFilters copyWith({String? search, String? rubro, bool? activo}) {
    return ArticuloFilters(
      search: search ?? this.search,
      rubro: rubro ?? this.rubro,
      activo: activo ?? this.activo,
    );
  }
}

class ArticuloFiltersNotifier extends Notifier<ArticuloFilters> {
  @override
  ArticuloFilters build() => const ArticuloFilters();

  void update(ArticuloFilters filters) => state = filters;
}

final articuloFiltersProvider = NotifierProvider<ArticuloFiltersNotifier, ArticuloFilters>(
  ArticuloFiltersNotifier.new,
);

final articulosListProvider = FutureProvider<PaginatedResponse<ArticuloModel>>((ref) {
  final filters = ref.watch(articuloFiltersProvider);
  return ref.read(articulosRepositoryProvider).listar(
        search: filters.search,
        rubro: filters.rubro,
        activo: filters.activo,
      );
});

final articuloDetailProvider = FutureProvider.family<ArticuloModel, String>((ref, id) {
  return ref.read(articulosRepositoryProvider).ver(id);
});

final articuloMovimientosProvider =
    FutureProvider.family<List<MovimientoStockModel>, String>((ref, id) {
  return ref.read(articulosRepositoryProvider).movimientos(id);
});

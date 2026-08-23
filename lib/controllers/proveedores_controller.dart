import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compra_model.dart';
import '../models/paginated_response.dart';
import '../models/proveedor_cuenta_corriente_model.dart';
import '../models/proveedor_model.dart';
import '../providers/proveedores_providers.dart';

class ProveedorFiltros {
  const ProveedorFiltros({this.search, this.activo});

  final String? search;
  final bool? activo;

  ProveedorFiltros copyWith({String? search, bool? activo}) {
    return ProveedorFiltros(search: search ?? this.search, activo: activo ?? this.activo);
  }
}

class ProveedorFiltrosNotifier extends Notifier<ProveedorFiltros> {
  @override
  ProveedorFiltros build() => const ProveedorFiltros();

  void update(ProveedorFiltros filtros) => state = filtros;
}

final proveedorFiltrosProvider =
    NotifierProvider<ProveedorFiltrosNotifier, ProveedorFiltros>(ProveedorFiltrosNotifier.new);

final proveedoresListProvider = FutureProvider<PaginatedResponse<ProveedorModel>>((ref) {
  final filtros = ref.watch(proveedorFiltrosProvider);
  return ref.read(proveedoresRepositoryProvider).listar(search: filtros.search, activo: filtros.activo);
});

final proveedorDetailProvider = FutureProvider.family<ProveedorModel, String>((ref, id) {
  return ref.read(proveedoresRepositoryProvider).ver(id);
});

final proveedorComprasProvider = FutureProvider.family<PaginatedResponse<CompraModel>, String>(
  (ref, id) {
    return ref.read(proveedoresRepositoryProvider).compras(id);
  },
);

final proveedorCuentaCorrienteProvider =
    FutureProvider.family<ProveedorCuentaCorrienteModel, String>((ref, id) {
  return ref.read(proveedoresRepositoryProvider).cuentaCorriente(id);
});

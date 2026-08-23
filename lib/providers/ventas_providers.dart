import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/estadistica_mensual_model.dart';
import '../models/paginated_response.dart';
import '../models/producto_mas_vendido_model.dart';
import '../models/venta_estadisticas_model.dart';
import '../models/venta_model.dart';
import '../services/secure_storage_service.dart';
import '../services/ventas_api_service.dart';
import '../services/ventas_repository.dart';
import 'auth_providers.dart';
import 'sync_providers.dart';

final ventasRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return VentasRepository(
    VentasApiService(client),
    SecureStorageService(),
    ref.watch(appDatabaseProvider),
  );
});

/// null = todas, si no "completada" o "anulada".
class VentaFiltroEstadoNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void update(String? estado) => state = estado;
}

final ventaFiltroEstadoProvider =
    NotifierProvider<VentaFiltroEstadoNotifier, String?>(VentaFiltroEstadoNotifier.new);

final ventasListProvider = FutureProvider<PaginatedResponse<VentaModel>>((ref) {
  final estado = ref.watch(ventaFiltroEstadoProvider);
  return ref.read(ventasRepositoryProvider).listar(estado: estado);
});

final ventaDetailProvider = FutureProvider.family<VentaModel, String>((ref, id) {
  return ref.read(ventasRepositoryProvider).ver(id);
});

final ventasEstadisticasProvider = FutureProvider<VentasEstadisticasModel>((ref) {
  return ref.read(ventasRepositoryProvider).estadisticas();
});

/// 'dia', 'mes' o 'anio'.
class ProductoRankingPeriodoNotifier extends Notifier<String> {
  @override
  String build() => 'mes';

  void update(String periodo) => state = periodo;
}

final productoRankingPeriodoProvider =
    NotifierProvider<ProductoRankingPeriodoNotifier, String>(ProductoRankingPeriodoNotifier.new);

final productosMasVendidosProvider = FutureProvider<List<ProductoMasVendidoModel>>((ref) {
  final periodo = ref.watch(productoRankingPeriodoProvider);
  return ref.read(ventasRepositoryProvider).productosMasVendidos(periodo);
});

final ventasEstadisticasMensualesProvider = FutureProvider<List<EstadisticaMensualModel>>((ref) {
  return ref.read(ventasRepositoryProvider).estadisticasMensuales();
});

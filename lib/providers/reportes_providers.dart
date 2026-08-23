import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reporte_fila_model.dart';
import '../services/reportes_api_service.dart';
import '../services/reportes_repository.dart';
import 'auth_providers.dart';

final reportesRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return ReportesRepository(ReportesApiService(client));
});

class ReporteTipoNotifier extends Notifier<TipoReporte> {
  @override
  TipoReporte build() => TipoReporte.rubro;

  void elegir(TipoReporte tipo) => state = tipo;
}

final reporteTipoProvider = NotifierProvider<ReporteTipoNotifier, TipoReporte>(
  ReporteTipoNotifier.new,
);

/// Primer día del mes que se está mirando — mismo patrón que Comisiones.
class ReporteMesNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    final ahora = DateTime.now();
    return DateTime(ahora.year, ahora.month, 1);
  }

  void irAMes(DateTime primerDia) => state = primerDia;
}

final reporteMesProvider = NotifierProvider<ReporteMesNotifier, DateTime>(ReporteMesNotifier.new);

final reporteDataProvider = FutureProvider<List<ReporteFilaModel>>((ref) {
  final tipo = ref.watch(reporteTipoProvider);
  final mes = ref.watch(reporteMesProvider);
  final desde = DateTime(mes.year, mes.month, 1);
  final hasta = DateTime(mes.year, mes.month + 1, 0);
  return ref.read(reportesRepositoryProvider).ventasPor(tipo, desde: desde, hasta: hasta);
});

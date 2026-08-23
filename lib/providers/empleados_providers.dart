import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/comision_empleado_model.dart';
import '../models/empleado_model.dart';
import '../services/empleados_api_service.dart';
import '../services/empleados_repository.dart';
import 'auth_providers.dart';

final empleadosRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiClientProvider);
  return EmpleadosRepository(EmpleadosApiService(client));
});

final empleadosListProvider = FutureProvider<List<EmpleadoModel>>((ref) {
  return ref.read(empleadosRepositoryProvider).listar();
});

/// Primer día del mes que se está mirando en el reporte de comisiones.
class ComisionesMesNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    final ahora = DateTime.now();
    return DateTime(ahora.year, ahora.month, 1);
  }

  void irAMes(DateTime primerDia) => state = primerDia;
}

final comisionesMesProvider = NotifierProvider<ComisionesMesNotifier, DateTime>(
  ComisionesMesNotifier.new,
);

final comisionesReporteProvider = FutureProvider<ComisionesReporteModel>((ref) {
  final mes = ref.watch(comisionesMesProvider);
  final desde = DateTime(mes.year, mes.month, 1);
  final hasta = DateTime(mes.year, mes.month + 1, 0);
  return ref.read(empleadosRepositoryProvider).comisiones(desde: desde, hasta: hasta);
});

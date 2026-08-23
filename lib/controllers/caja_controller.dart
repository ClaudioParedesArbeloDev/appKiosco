import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/caja_model.dart';
import '../models/paginated_response.dart';
import '../providers/caja_providers.dart';

/// Estado de la caja actual. Null significa "no hay caja abierta".
class CajaController extends AsyncNotifier<CajaModel?> {
  @override
  Future<CajaModel?> build() {
    return ref.read(cajaRepositoryProvider).actual();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(cajaRepositoryProvider).actual());
  }

  Future<void> abrir(int montoInicial) async {
    final caja = await ref.read(cajaRepositoryProvider).abrir(montoInicial);
    state = AsyncValue.data(caja);
    await refresh(); // trae el resumen recién creado, no solo la fila cruda
  }

  Future<void> registrarMovimiento({
    required String tipo,
    required int monto,
    required String nota,
  }) async {
    await ref.read(cajaRepositoryProvider).registrarMovimiento(
          tipo: tipo,
          monto: monto,
          nota: nota,
        );
    await refresh();
  }

  /// Devuelve la caja ya cerrada (con el resumen final) para poder mostrar
  /// el resultado del arqueo, y deja el estado en null (no hay caja abierta).
  Future<CajaModel> cerrar(int montoFinalDeclarado) async {
    final cajaCerrada = await ref.read(cajaRepositoryProvider).cerrar(montoFinalDeclarado);
    state = const AsyncValue.data(null);
    return cajaCerrada;
  }
}

final cajaControllerProvider = AsyncNotifierProvider<CajaController, CajaModel?>(
  CajaController.new,
);

final cajaHistorialProvider = FutureProvider<PaginatedResponse<CajaModel>>((ref) {
  return ref.read(cajaRepositoryProvider).historial();
});

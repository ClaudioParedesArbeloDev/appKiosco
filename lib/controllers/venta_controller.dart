import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/venta_model.dart';
import '../providers/ventas_providers.dart';
import 'caja_controller.dart';

/// El estado es la última venta confirmada (o null si todavía no se
/// confirmó ninguna). No es una lista ni algo que se "recarga": cada
/// submit es una acción puntual.
class VentaController extends AsyncNotifier<VentaModel?> {
  @override
  Future<VentaModel?> build() async => null;

  Future<void> confirmar({
    required List<CartItem> items,
    required String formaPago,
    String? clienteId,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () => ref.read(ventasRepositoryProvider).crear(
            items: items,
            formaPago: formaPago,
            clienteId: clienteId,
          ),
    );

    // Una venta en efectivo/tarjeta con caja abierta mueve un
    // CajaMovimiento del lado del server automáticamente — sin este
    // refresh, la pantalla de Caja (si ya estaba abierta en otra pestaña)
    // se quedaba mostrando los números de antes de la venta.
    if (state.hasValue && state.value != null) {
      await ref.read(cajaControllerProvider.notifier).refresh();
    }
  }

  void limpiar() => state = const AsyncValue.data(null);
}

final ventaControllerProvider = AsyncNotifierProvider<VentaController, VentaModel?>(
  VentaController.new,
);

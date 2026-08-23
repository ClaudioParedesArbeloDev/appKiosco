import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/articulo_model.dart';
import '../models/cart_item.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  final _audioPlayer = AudioPlayer();

  @override
  List<CartItem> build() {
    ref.onDispose(_audioPlayer.dispose);
    return [];
  }

  /// Confirma con un sonido que el producto se sumó a la venta — corre acá
  /// (no en el lector) para que suene siempre del lado de la PC que está
  /// cobrando, sea cual sea el origen del código (escaneo remoto del
  /// celular, búsqueda manual, o un lector de código de barras USB futuro).
  void agregar(ArticuloModel articulo) {
    _audioPlayer.play(AssetSource('audio/beep.wav'));

    final index = state.indexWhere((item) => item.articulo.id == articulo.id);

    if (index == -1) {
      state = [...state, CartItem(articulo: articulo, cantidad: 1)];
      return;
    }

    actualizarCantidad(articulo.id, state[index].cantidad + 1);
  }

  void actualizarCantidad(String articuloId, int cantidad) {
    if (cantidad <= 0) {
      quitar(articuloId);
      return;
    }

    state = [
      for (final item in state)
        if (item.articulo.id == articuloId) item.copyWith(cantidad: cantidad) else item,
    ];
  }

  void quitar(String articuloId) {
    state = state.where((item) => item.articulo.id != articuloId).toList();
  }

  void vaciar() => state = [];
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);

final cartTotalProvider = Provider<int>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0, (total, item) => total + item.subtotal);
});

import 'articulo_model.dart';

/// Un renglón del carrito de la pantalla de venta. Vive solo en memoria
/// hasta que se confirma la venta — no es un modelo que venga del backend.
class CartItem {
  const CartItem({required this.articulo, required this.cantidad});

  final ArticuloModel articulo;
  final int cantidad;

  int get subtotal => articulo.precioVigente * cantidad;
  double get subtotalPesos => subtotal / 100;

  CartItem copyWith({int? cantidad}) {
    return CartItem(articulo: articulo, cantidad: cantidad ?? this.cantidad);
  }
}

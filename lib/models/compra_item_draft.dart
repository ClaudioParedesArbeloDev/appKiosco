import '../models/articulo_model.dart';

/// Un renglón de compra todavía en edición en el form — a diferencia de
/// `CartItem` (venta), acá el precio lo escribe el usuario, no viene del
/// artículo.
class CompraItemDraft {
  const CompraItemDraft({
    required this.articulo,
    required this.cantidad,
    required this.precioUnitario,
  });

  final ArticuloModel articulo;
  final int cantidad;

  /// En centavos.
  final int precioUnitario;

  int get subtotal => cantidad * precioUnitario;

  CompraItemDraft copyWith({int? cantidad, int? precioUnitario}) {
    return CompraItemDraft(
      articulo: articulo,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
    );
  }
}

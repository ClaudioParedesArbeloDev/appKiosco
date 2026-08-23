import 'articulo_model.dart';

/// Un renglón en edición para presupuesto/remito — a diferencia de una
/// compra, acá el precio lo calcula siempre el servidor (`precio_vigente`
/// del artículo), nunca lo escribe el usuario.
class ItemCantidadDraft {
  const ItemCantidadDraft({required this.articulo, required this.cantidad});

  final ArticuloModel articulo;
  final int cantidad;

  ItemCantidadDraft copyWith({int? cantidad}) {
    return ItemCantidadDraft(articulo: articulo, cantidad: cantidad ?? this.cantidad);
  }
}

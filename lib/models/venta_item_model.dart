class VentaItemModel {
  const VentaItemModel({
    required this.id,
    required this.articuloDescripcion,
    required this.cantidad,
    required this.precioUnitario,
    required this.subtotal,
  });

  final String id;
  final String articuloDescripcion;
  final int cantidad;

  /// En centavos, como todo el dinero en Code & Lens.
  final int precioUnitario;
  final int subtotal;

  double get precioUnitarioPesos => precioUnitario / 100;
  double get subtotalPesos => subtotal / 100;

  factory VentaItemModel.fromJson(Map<String, dynamic> json) {
    return VentaItemModel(
      id: json['id'] as String,
      articuloDescripcion: json['articulo']['descripcion'] as String,
      cantidad: json['cantidad'] as int,
      precioUnitario: json['precio_unitario'] as int,
      subtotal: json['subtotal'] as int,
    );
  }
}

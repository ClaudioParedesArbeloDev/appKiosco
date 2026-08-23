class NotaCreditoItemModel {
  const NotaCreditoItemModel({
    required this.articuloDescripcion,
    required this.cantidad,
    required this.precioUnitario,
    required this.subtotal,
  });

  final String articuloDescripcion;
  final int cantidad;
  final int precioUnitario;
  final int subtotal;

  double get precioUnitarioPesos => precioUnitario / 100;
  double get subtotalPesos => subtotal / 100;

  factory NotaCreditoItemModel.fromJson(Map<String, dynamic> json) {
    return NotaCreditoItemModel(
      articuloDescripcion: json['articulo']['descripcion'] as String,
      cantidad: json['cantidad'] as int,
      precioUnitario: json['precio_unitario'] as int,
      subtotal: json['subtotal'] as int,
    );
  }
}

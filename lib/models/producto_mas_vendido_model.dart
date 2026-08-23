class ProductoMasVendidoModel {
  const ProductoMasVendidoModel({
    required this.articuloId,
    required this.descripcion,
    required this.cantidadVendida,
    required this.totalVendido,
  });

  final String articuloId;
  final String descripcion;
  final int cantidadVendida;

  /// En centavos, como todo el dinero en Code & Lens.
  final int totalVendido;

  double get totalVendidoPesos => totalVendido / 100;

  factory ProductoMasVendidoModel.fromJson(Map<String, dynamic> json) {
    return ProductoMasVendidoModel(
      articuloId: json['articulo_id'] as String,
      descripcion: json['descripcion'] as String,
      cantidadVendida: json['cantidad_vendida'] as int,
      totalVendido: json['total_vendido'] as int,
    );
  }
}

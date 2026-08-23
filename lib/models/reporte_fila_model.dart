class ReporteFilaModel {
  const ReporteFilaModel({
    required this.etiqueta,
    required this.cantidad,
    required this.totalVendido,
    this.costo,
    this.ganancia,
  });

  final String etiqueta;
  final int cantidad;

  /// En centavos, como todo el dinero en Code & Lens.
  final int totalVendido;

  /// Solo vienen en "por rubro"/"por marca" — costo actual del artículo,
  /// no histórico al momento de la venta.
  final int? costo;
  final int? ganancia;

  double get totalVendidoPesos => totalVendido / 100;
  double? get gananciaPesos => ganancia == null ? null : ganancia! / 100;

  factory ReporteFilaModel.fromJson(Map<String, dynamic> json) {
    return ReporteFilaModel(
      etiqueta: json['etiqueta'] as String,
      cantidad: json['cantidad'] as int,
      totalVendido: json['total_vendido'] as int,
      costo: json['costo'] as int?,
      ganancia: json['ganancia'] as int?,
    );
  }
}

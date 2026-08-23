class MovimientoStockModel {
  const MovimientoStockModel({
    required this.id,
    required this.cantidad,
    required this.motivo,
    required this.createdAt,
    this.nota,
    this.usuarioNombre,
  });

  final String id;
  final int cantidad;
  final String motivo;
  final String? nota;
  final String? usuarioNombre;
  final DateTime createdAt;

  factory MovimientoStockModel.fromJson(Map<String, dynamic> json) {
    return MovimientoStockModel(
      id: json['id'] as String,
      cantidad: json['cantidad'] as int,
      motivo: json['motivo'] as String,
      nota: json['nota'] as String?,
      usuarioNombre: json['usuario'] == null ? null : json['usuario']['name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  bool get esEntrada => cantidad > 0;
}

class CajaMovimientoModel {
  const CajaMovimientoModel({
    required this.id,
    required this.tipo,
    required this.monto,
    this.formaPago,
    this.nota,
    this.createdAt,
  });

  final String id;

  /// 'venta' | 'ingreso' | 'retiro'
  final String tipo;

  /// Positivo = entrada, negativo = salida.
  final int monto;
  final String? formaPago;
  final String? nota;
  final DateTime? createdAt;

  double get montoPesos => monto / 100;

  factory CajaMovimientoModel.fromJson(Map<String, dynamic> json) {
    return CajaMovimientoModel(
      id: json['id'] as String,
      tipo: json['tipo'] as String,
      monto: json['monto'] as int,
      formaPago: json['forma_pago'] as String?,
      nota: json['nota'] as String?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    );
  }
}

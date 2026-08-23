class CuentaCorrienteMovimientoModel {
  const CuentaCorrienteMovimientoModel({
    required this.id,
    required this.tipo,
    required this.monto,
    required this.createdAt,
    this.usuarioNombre,
    this.nota,
  });

  final String id;

  /// 'venta' | 'pago' | 'ajuste'
  final String tipo;

  /// En centavos. Positivo = aumenta la deuda, negativo = la reduce.
  final int monto;
  final DateTime createdAt;
  final String? usuarioNombre;
  final String? nota;

  double get montoPesos => monto / 100;

  factory CuentaCorrienteMovimientoModel.fromJson(Map<String, dynamic> json) {
    return CuentaCorrienteMovimientoModel(
      id: json['id'] as String,
      tipo: json['tipo'] as String,
      monto: json['monto'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      usuarioNombre: (json['usuario'] as Map<String, dynamic>?)?['name'] as String?,
      nota: json['nota'] as String?,
    );
  }
}

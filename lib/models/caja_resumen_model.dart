/// Resumen de una caja: viene calculado del backend (suma de movimientos),
/// nunca se calcula en el cliente. Todos los montos en centavos.
class CajaResumenModel {
  const CajaResumenModel({
    required this.montoInicial,
    required this.ventas,
    required this.ingresos,
    required this.retiros,
    required this.totalEfectivo,
    required this.totalTarjeta,
  });

  final int montoInicial;
  final int ventas;
  final int ingresos;
  final int retiros;
  final int totalEfectivo;
  final int totalTarjeta;

  double get montoInicialPesos => montoInicial / 100;
  double get ventasPesos => ventas / 100;
  double get ingresosPesos => ingresos / 100;
  double get retirosPesos => retiros / 100;
  double get totalEfectivoPesos => totalEfectivo / 100;
  double get totalTarjetaPesos => totalTarjeta / 100;

  factory CajaResumenModel.fromJson(Map<String, dynamic> json) {
    return CajaResumenModel(
      montoInicial: json['monto_inicial'] as int,
      ventas: json['ventas'] as int,
      ingresos: json['ingresos'] as int,
      retiros: json['retiros'] as int,
      totalEfectivo: json['total_efectivo'] as int,
      totalTarjeta: json['total_tarjeta'] as int,
    );
  }
}

class VentaResumenPeriodo {
  const VentaResumenPeriodo({
    required this.total,
    required this.cantidad,
    required this.efectivo,
    required this.tarjeta,
    required this.cuentaCorriente,
  });

  /// En centavos, como todo el dinero en Code & Lens.
  final int total;
  final int cantidad;
  final int efectivo;
  final int tarjeta;
  final int cuentaCorriente;

  double get totalPesos => total / 100;
  double get efectivoPesos => efectivo / 100;
  double get tarjetaPesos => tarjeta / 100;
  double get cuentaCorrientePesos => cuentaCorriente / 100;

  factory VentaResumenPeriodo.fromJson(Map<String, dynamic> json) {
    return VentaResumenPeriodo(
      total: json['total'] as int,
      cantidad: json['cantidad'] as int,
      efectivo: json['efectivo'] as int,
      tarjeta: json['tarjeta'] as int,
      cuentaCorriente: json['cuenta_corriente'] as int,
    );
  }
}

class VentasEstadisticasModel {
  const VentasEstadisticasModel({
    required this.hoy,
    required this.semana,
    required this.mes,
    required this.anio,
  });

  final VentaResumenPeriodo hoy;
  final VentaResumenPeriodo semana;
  final VentaResumenPeriodo mes;
  final VentaResumenPeriodo anio;

  factory VentasEstadisticasModel.fromJson(Map<String, dynamic> json) {
    return VentasEstadisticasModel(
      hoy: VentaResumenPeriodo.fromJson(json['hoy']),
      semana: VentaResumenPeriodo.fromJson(json['semana']),
      mes: VentaResumenPeriodo.fromJson(json['mes']),
      anio: VentaResumenPeriodo.fromJson(json['anio']),
    );
  }
}

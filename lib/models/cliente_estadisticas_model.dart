class ClienteResumenPeriodo {
  const ClienteResumenPeriodo({required this.total, required this.cantidad});

  /// En centavos, como todo el dinero en Code & Lens.
  final int total;
  final int cantidad;

  double get totalPesos => total / 100;

  factory ClienteResumenPeriodo.fromJson(Map<String, dynamic> json) {
    return ClienteResumenPeriodo(
      total: json['total'] as int,
      cantidad: json['cantidad'] as int,
    );
  }
}

class ClienteEstadisticasModel {
  const ClienteEstadisticasModel({required this.hoy, required this.mes, required this.anio});

  final ClienteResumenPeriodo hoy;
  final ClienteResumenPeriodo mes;
  final ClienteResumenPeriodo anio;

  factory ClienteEstadisticasModel.fromJson(Map<String, dynamic> json) {
    return ClienteEstadisticasModel(
      hoy: ClienteResumenPeriodo.fromJson(json['hoy']),
      mes: ClienteResumenPeriodo.fromJson(json['mes']),
      anio: ClienteResumenPeriodo.fromJson(json['anio']),
    );
  }
}

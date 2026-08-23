class ComisionEmpleadoModel {
  const ComisionEmpleadoModel({
    required this.userId,
    required this.name,
    required this.cantidadVentas,
    required this.totalVendido,
    required this.comisionCalculada,
    this.comisionPorcentaje,
  });

  final String userId;
  final String name;

  /// Null = sin comisión configurada.
  final int? comisionPorcentaje;
  final int cantidadVentas;

  /// En centavos, como todo el dinero en Code & Lens.
  final int totalVendido;
  final int comisionCalculada;

  double get totalVendidoPesos => totalVendido / 100;
  double get comisionCalculadaPesos => comisionCalculada / 100;

  factory ComisionEmpleadoModel.fromJson(Map<String, dynamic> json) {
    return ComisionEmpleadoModel(
      userId: json['user_id'] as String,
      name: json['name'] as String,
      comisionPorcentaje: json['comision_porcentaje'] as int?,
      cantidadVentas: json['cantidad_ventas'] as int,
      totalVendido: json['total_vendido'] as int,
      comisionCalculada: json['comision_calculada'] as int,
    );
  }
}

class ComisionesReporteModel {
  const ComisionesReporteModel({required this.desde, required this.hasta, required this.empleados});

  final DateTime desde;
  final DateTime hasta;
  final List<ComisionEmpleadoModel> empleados;

  factory ComisionesReporteModel.fromJson(Map<String, dynamic> json) {
    return ComisionesReporteModel(
      desde: DateTime.parse(json['desde'] as String),
      hasta: DateTime.parse(json['hasta'] as String),
      empleados: (json['empleados'] as List)
          .map((e) => ComisionEmpleadoModel.fromJson(e))
          .toList(),
    );
  }
}

class EstadisticaMensualModel {
  const EstadisticaMensualModel({
    required this.anio,
    required this.mes,
    required this.total,
    required this.cantidad,
  });

  final int anio;

  /// 1 a 12.
  final int mes;

  /// En centavos, como todo el dinero en Code & Lens.
  final int total;
  final int cantidad;

  double get totalPesos => total / 100;

  factory EstadisticaMensualModel.fromJson(Map<String, dynamic> json) {
    return EstadisticaMensualModel(
      anio: json['anio'] as int,
      mes: json['mes'] as int,
      total: json['total'] as int,
      cantidad: json['cantidad'] as int,
    );
  }
}

const nombresMesesCortos = [
  '',
  'Ene',
  'Feb',
  'Mar',
  'Abr',
  'May',
  'Jun',
  'Jul',
  'Ago',
  'Sep',
  'Oct',
  'Nov',
  'Dic',
];

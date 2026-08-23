class DispositivoModel {
  const DispositivoModel({
    required this.id,
    required this.primeraVezAt,
    required this.ultimaVezAt,
    required this.tieneCajaAbierta,
    this.nombre,
    this.desactivadoAt,
  });

  final String id;
  final String? nombre;
  final DateTime primeraVezAt;
  final DateTime ultimaVezAt;
  final DateTime? desactivadoAt;
  final bool tieneCajaAbierta;

  bool get activo => desactivadoAt == null;

  factory DispositivoModel.fromJson(Map<String, dynamic> json) {
    return DispositivoModel(
      id: json['id'] as String,
      nombre: json['nombre'] as String?,
      primeraVezAt: DateTime.parse(json['primera_vez_at'] as String),
      ultimaVezAt: DateTime.parse(json['ultima_vez_at'] as String),
      desactivadoAt:
          json['desactivado_at'] == null ? null : DateTime.parse(json['desactivado_at'] as String),
      tieneCajaAbierta: json['tiene_caja_abierta'] as bool,
    );
  }
}

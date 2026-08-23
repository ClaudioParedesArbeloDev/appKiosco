class ClienteModel {
  const ClienteModel({
    required this.id,
    required this.nombre,
    required this.condicionIva,
    required this.porcentajeDescuento,
    required this.activo,
    this.dniCuit,
    this.direccion,
    this.telefono,
    this.email,
    this.zona,
    this.limiteCuentaCorriente,
  });

  final String id;
  final String nombre;
  final String? dniCuit;
  final String condicionIva;
  final String? direccion;
  final String? telefono;
  final String? email;
  final String? zona;
  final int porcentajeDescuento;
  final bool activo;

  /// En centavos. Null = sin límite.
  final int? limiteCuentaCorriente;

  double? get limiteCuentaCorrientePesos =>
      limiteCuentaCorriente == null ? null : limiteCuentaCorriente! / 100;

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      dniCuit: json['dni_cuit'] as String?,
      condicionIva: json['condicion_iva'] as String,
      direccion: json['direccion'] as String?,
      telefono: json['telefono'] as String?,
      email: json['email'] as String?,
      zona: json['zona'] as String?,
      porcentajeDescuento: json['porcentaje_descuento'] as int? ?? 0,
      activo: json['activo'] as bool? ?? true,
      limiteCuentaCorriente: json['limite_cuenta_corriente'] as int?,
    );
  }
}

const condicionesIva = {
  'consumidor_final': 'Consumidor Final',
  'responsable_inscripto': 'Responsable Inscripto',
  'monotributista': 'Monotributista',
  'exento': 'Exento',
};

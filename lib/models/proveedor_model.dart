class ProveedorModel {
  const ProveedorModel({
    required this.id,
    required this.nombre,
    required this.activo,
    this.cuit,
    this.contacto,
    this.direccion,
    this.telefono,
    this.email,
  });

  final String id;
  final String nombre;
  final String? cuit;
  final String? contacto;
  final String? direccion;
  final String? telefono;
  final String? email;
  final bool activo;

  factory ProveedorModel.fromJson(Map<String, dynamic> json) {
    return ProveedorModel(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      cuit: json['cuit'] as String?,
      contacto: json['contacto'] as String?,
      direccion: json['direccion'] as String?,
      telefono: json['telefono'] as String?,
      email: json['email'] as String?,
      activo: json['activo'] as bool? ?? true,
    );
  }
}

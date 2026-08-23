import '../core/producto.dart';

enum CondicionIva {
  monotributista,
  responsableInscripto,
  exento;

  String get apiValue => switch (this) {
        CondicionIva.monotributista => 'monotributista',
        CondicionIva.responsableInscripto => 'responsable_inscripto',
        CondicionIva.exento => 'exento',
      };

  String get label => switch (this) {
        CondicionIva.monotributista => 'Monotributista',
        CondicionIva.responsableInscripto => 'Responsable Inscripto',
        CondicionIva.exento => 'Exento',
      };
}

/// Datos del formulario de alta de un comercio nuevo.
class TenantRegistrationData {
  const TenantRegistrationData({
    required this.nombreComercio,
    required this.titular,
    required this.rubro,
    required this.direccion,
    required this.cuit,
    required this.condicionIva,
    required this.telefonoContacto,
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  final String nombreComercio;
  final String titular;
  final String rubro;
  final String direccion;
  final String cuit;
  final CondicionIva condicionIva;
  final String telefonoContacto;
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  Map<String, dynamic> toJson() => {
        'nombre_comercio': nombreComercio,
        'titular': titular,
        'rubro': rubro,
        'producto': kProducto,
        'direccion': direccion,
        'cuit': cuit,
        'condicion_iva': condicionIva.apiValue,
        'telefono_contacto': telefonoContacto,
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'device_name': 'flutter-app',
      };
}

/// Un negocio entre los que puede elegir esta identidad al loguearse, cuando
/// el mismo mail tiene más de un negocio para el mismo producto.
class TenantOption {
  const TenantOption({required this.id, required this.nombreComercio});

  final String id;
  final String nombreComercio;

  factory TenantOption.fromJson(Map<String, dynamic> json) => TenantOption(
        id: json['id'] as String,
        nombreComercio: json['nombre_comercio'] as String,
      );
}

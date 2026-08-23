class EmpleadoModel {
  const EmpleadoModel({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.roles,
    this.comisionPorcentaje,
  });

  final String id;
  final String name;
  final String email;

  /// 'active' | 'invited' | 'suspended'
  final String status;
  final List<String> roles;

  /// Null = sin comisión configurada.
  final int? comisionPorcentaje;

  bool get isAdminComercio => roles.contains('admin_comercio');
  bool get activo => status == 'active';

  factory EmpleadoModel.fromJson(Map<String, dynamic> json) {
    return EmpleadoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
      roles: json['roles'] == null
          ? []
          : (json['roles'] as List).map((r) => r['slug'] as String).toList(),
      comisionPorcentaje: json['comision_porcentaje'] as int?,
    );
  }
}

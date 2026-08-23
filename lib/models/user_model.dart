class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.permissions,
    this.avatarUrl,
    this.roleNames = const [],
    this.nombreComercio,
    this.logoComercioUrl,
    this.impresoraFiscalMarca,
    this.impresoraFiscalPuerto,
    this.impresoraFiscalBaudRate,
  });

  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final List<String> roles;
  final List<String> roleNames;
  final List<String> permissions;

  /// Datos del comercio (tenant) del usuario — null para el superadmin de
  /// la plataforma, que no pertenece a ningún comercio.
  final String? nombreComercio;
  final String? logoComercioUrl;

  /// Config de la impresora fiscal del comercio. 'hasar' | 'epson' |
  /// 'custom' | null (sin configurar). Hoy ningún driver está implementado
  /// todavía — ver [[arbelo-backend-architecture]] — así que esto solo
  /// guarda la configuración para cuando se agregue soporte real.
  final String? impresoraFiscalMarca;
  final String? impresoraFiscalPuerto;
  final int? impresoraFiscalBaudRate;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final tenant = json['tenant'] as Map<String, dynamic>?;

    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
      roles: json['roles'] == null
          ? []
          : (json['roles'] as List).map((r) => r['slug'] as String).toList(),
      roleNames: json['roles'] == null
          ? []
          : (json['roles'] as List).map((r) => r['name'] as String).toList(),
      permissions: json['permissions'] == null
          ? []
          : (json['permissions'] as List).map((p) => p['slug'] as String).toList(),
      nombreComercio: tenant?['nombre_comercio'] as String?,
      logoComercioUrl: tenant?['logo_url'] as String?,
      impresoraFiscalMarca: tenant?['impresora_fiscal_marca'] as String?,
      impresoraFiscalPuerto: tenant?['impresora_fiscal_puerto'] as String?,
      impresoraFiscalBaudRate: tenant?['impresora_fiscal_baud_rate'] as int?,
    );
  }

  bool hasRole(String slug) => roles.contains(slug);
  bool get isAdminComercio => hasRole('admin_comercio');
  String get displayRole => roleNames.isEmpty ? '' : roleNames.join(', ');

  bool hasPermission(String slug) {
    if (isAdminComercio) return true;
    return permissions.contains(slug);
  }
}

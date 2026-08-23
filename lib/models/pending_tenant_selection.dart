import 'tenant_option.dart';

/// Lo que hace falta para completar el login una vez que el usuario elige
/// el negocio — distinto según cómo se validó la identidad (contraseña,
/// Google mobile con idToken, o Google desktop con ticket), por eso
/// variantes separadas en vez de un solo tipo genérico.
sealed class PendingTenantSelection {
  List<TenantOption> get tenants;
}

class PendingPasswordSelection extends PendingTenantSelection {
  PendingPasswordSelection({
    required this.email,
    required this.password,
    required this.producto,
    required this.tenants,
  });

  final String email;
  final String password;
  final String producto;

  @override
  final List<TenantOption> tenants;
}

class PendingGoogleMobileSelection extends PendingTenantSelection {
  PendingGoogleMobileSelection({required this.idToken, required this.producto, required this.tenants});

  final String idToken;
  final String producto;

  @override
  final List<TenantOption> tenants;
}

class PendingGoogleDesktopSelection extends PendingTenantSelection {
  PendingGoogleDesktopSelection({required this.ticket, required this.tenants});

  final String ticket;

  @override
  final List<TenantOption> tenants;
}

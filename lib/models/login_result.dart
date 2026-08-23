import 'tenant_option.dart';
import 'user_model.dart';

/// Resultado de un intento de login/registro — puede terminar logueado, o
/// necesitar que el usuario elija a cuál de sus negocios quiere entrar
/// (mismo mail con más de un negocio del mismo producto).
sealed class LoginResult {}

class LoggedIn extends LoginResult {
  LoggedIn(this.user);

  final UserModel user;
}

class NeedsTenantSelection extends LoginResult {
  NeedsTenantSelection(this.tenants);

  final List<TenantOption> tenants;
}

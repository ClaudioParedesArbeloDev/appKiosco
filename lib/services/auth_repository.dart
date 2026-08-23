import '../core/network/api_client.dart';
import '../models/login_result.dart';
import '../models/tenant_option.dart';
import '../models/tenant_registration_data.dart';
import '../models/user_model.dart';
import 'auth_api_service.dart';
import 'secure_storage_service.dart';

class AuthRepository {
  AuthRepository(this._api, this._client, this._storage);

  final AuthApiService _api;
  final ApiClient _client;
  final SecureStorageService _storage;

  Future<LoginResult> login(
    String email,
    String password,
    String deviceName, {
    String? producto,
    String? tenantId,
  }) async {
    final response = await _api.login(
      email, password, deviceName,
      producto: producto, tenantId: tenantId,
    );

    return _resultFrom(response.data);
  }

  Future<UserModel> register(TenantRegistrationData data) async {
    final response = await _api.register(data);
    final token = response.data['token'] as String;

    await _storage.saveToken(token);
    _client.setToken(token);

    return UserModel.fromJson(response.data['user']);
  }

  // Mobile: ya tenemos el idToken de google_sign_in, se lo mandamos a Laravel
  Future<LoginResult> loginWithGoogleIdToken(
    String idToken, {
    String? producto,
    String? tenantId,
  }) async {
    final response = await _api.loginWithGoogleIdToken(
      idToken, producto: producto, tenantId: tenantId,
    );

    return _resultFrom(response.data);
  }

  // Desktop: el token ya viene armado por Laravel, vía el servidor local
  Future<UserModel> loginWithToken(String token) async {
    await _storage.saveToken(token);
    _client.setToken(token);

    final response = await _api.me();
    return UserModel.fromJson(response.data);
  }

  // Desktop con Google + selección de negocio: el server local recibió un
  // ticket (no un token) porque el mail tiene más de un negocio — este es
  // el paso que confirma cuál y recién ahí devuelve el token real.
  Future<LoginResult> selectTenantForGoogle(String ticket, String tenantId, String deviceName) async {
    final response = await _api.selectTenantForGoogle(
      ticket: ticket, tenantId: tenantId, deviceName: deviceName,
    );

    return _resultFrom(response.data);
  }

  Future<LoginResult> _resultFrom(Map<String, dynamic> data) async {
    if (data['requires_tenant_selection'] == true) {
      final tenants = (data['tenants'] as List)
          .map((t) => TenantOption.fromJson(t as Map<String, dynamic>))
          .toList();
      return NeedsTenantSelection(tenants);
    }

    final token = data['token'] as String;
    await _storage.saveToken(token);
    _client.setToken(token);

    return LoggedIn(UserModel.fromJson(data['user']));
  }

  Future<void> forgotPassword(String email) async {
    await _api.forgotPassword(email);
  }

  Future<void> logout() async {
    try {
      await _api.logout();
    } catch (_) {
      // Si el token ya era inválido en el servidor, no importa —
      // igual queremos limpiar la sesión del lado del cliente.
    }

    await _storage.deleteToken();
    _client.setToken(null);
  }

  /// Recarga el usuario logueado desde el backend — se usa después de
  /// acciones que cambian datos que no vienen en el token (ej. el logo del
  /// comercio), para reflejarlas sin tener que desloguear y volver a entrar.
  Future<UserModel> obtenerUsuarioActual() async {
    final response = await _api.me();
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> actualizarPerfil({required String name}) async {
    final response = await _api.actualizarPerfil(name: name);
    return UserModel.fromJson(response.data);
  }

  Future<UserModel?> tryAutoLogin() async {
    final token = await _storage.getToken();
    if (token == null) return null;

    _client.setToken(token);
    final response = await _api.me();
    return UserModel.fromJson(response.data);
  }
}

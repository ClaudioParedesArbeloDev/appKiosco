import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/producto.dart';
import '../models/login_result.dart';
import '../models/pending_tenant_selection.dart';
import '../models/tenant_registration_data.dart';
import '../models/tenant_option.dart';
import '../models/user_model.dart';
import '../providers/auth_providers.dart';
import '../services/google_auth_service.dart';

class AuthController extends AsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async {
    return ref.read(authRepositoryProvider).tryAutoLogin();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    final guarded = await AsyncValue.guard(
      () => repository.login(email, password, 'flutter-app', producto: kProducto),
    );

    _handleLoginResult(guarded, pendingFor: (tenants) => PendingPasswordSelection(
          email: email, password: password, producto: kProducto, tenants: tenants,
        ));
  }

  /// Segundo paso cuando `login()`/Google devolvió `requires_tenant_selection`
  /// — reenvía con el `tenant_id` elegido, usando lo que quedó guardado en
  /// [pendingTenantSelectionProvider].
  Future<void> selectTenant(String tenantId) async {
    final pending = ref.read(pendingTenantSelectionProvider);
    if (pending == null) return;

    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    final guarded = await AsyncValue.guard(() => switch (pending) {
          PendingPasswordSelection(:final email, :final password, :final producto) =>
            repository.login(email, password, 'flutter-app', producto: producto, tenantId: tenantId),
          PendingGoogleMobileSelection(:final idToken, :final producto) =>
            repository.loginWithGoogleIdToken(idToken, producto: producto, tenantId: tenantId),
          PendingGoogleDesktopSelection(:final ticket) =>
            repository.selectTenantForGoogle(ticket, tenantId, 'flutter-app'),
        });

    // No debería volver a pedir selección (ya mandamos un tenant_id
    // puntual), pero si pasara, no tenemos con qué re-armar el pending.
    _handleLoginResult(guarded, pendingFor: (_) => null);
  }

  void _handleLoginResult(
    AsyncValue<LoginResult> guarded, {
    required PendingTenantSelection? Function(List<TenantOption> tenants) pendingFor,
  }) {
    guarded.when(
      data: (result) {
        switch (result) {
          case LoggedIn(:final user):
            ref.read(pendingTenantSelectionProvider.notifier).set(null);
            state = AsyncValue.data(user);
          case NeedsTenantSelection(:final tenants):
            state = const AsyncValue.data(null);
            ref.read(pendingTenantSelectionProvider.notifier).set(pendingFor(tenants));
        }
      },
      error: (error, stackTrace) => state = AsyncValue.error(error, stackTrace),
      loading: () {},
    );
  }

  Future<void> register(TenantRegistrationData data) async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() => repository.register(data));
  }

  // Mobile: todo el flujo termina acá mismo, de forma síncrona (salvo que
  // haga falta elegir negocio, mismo patrón que el login por contraseña).
  Future<void> loginWithGoogleMobile() async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);
    String? idToken;

    final guarded = await AsyncValue.guard(() async {
      idToken = await GoogleAuthService().signInMobile();
      if (idToken == null) {
        throw Exception('No se pudo obtener el token de Google.');
      }
      return repository.loginWithGoogleIdToken(idToken!, producto: kProducto);
    });

    _handleLoginResult(guarded, pendingFor: (tenants) => PendingGoogleMobileSelection(
          idToken: idToken!, producto: kProducto, tenants: tenants,
        ));
  }

  // Desktop: solo abre el navegador. El resultado llega después, de forma
  // asíncrona, vía DeepLinkService (ver completeGoogleLoginDesktop y
  // pendingGoogleTenantSelectionDesktop).
  Future<void> loginWithGoogleDesktop() async {
    await GoogleAuthService().signInDesktop();
  }

  Future<void> completeGoogleLoginDesktop(String token) async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() => repository.loginWithToken(token));
  }

  /// El server local del flujo desktop recibió un ticket en vez de un token
  /// (el mail tiene más de un negocio) — deja la selección pendiente para
  /// que la UI navegue a elegir cuál.
  void pendingGoogleTenantSelectionDesktop(String ticket, List<TenantOption> tenants) {
    ref.read(pendingTenantSelectionProvider.notifier).set(
          PendingGoogleDesktopSelection(ticket: ticket, tenants: tenants),
        );
  }

  Future<void> actualizarPerfil({required String name}) async {
    final repository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(() => repository.actualizarPerfil(name: name));
  }

  /// Recarga el usuario logueado sin pasar por el estado de loading — se
  /// usa para reflejar cambios que no vienen del login (ej. logo nuevo del
  /// comercio) sin generar parpadeos de navegación en las pantallas que
  /// escuchan este provider.
  Future<void> refrescarUsuario() async {
    final repository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(repository.obtenerUsuarioActual);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncValue.data(null);
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, UserModel?>(
  AuthController.new,
);

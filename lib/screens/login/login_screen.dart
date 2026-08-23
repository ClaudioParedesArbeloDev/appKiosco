import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/validation_errors.dart';
import '../../core/platform_helper.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../controllers/auth_controller.dart';
import '../../providers/auth_providers.dart';
import '../../services/deep_link_service.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';
import '../splash/widgets/app_logo.dart';
import 'forgot_password_screen.dart';
import 'select_business_screen.dart';
import 'widgets/login_google_button.dart';
import 'widgets/login_divider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    ref
        .read(authControllerProvider.notifier)
        .login(_emailController.text.trim(), _passwordController.text.trim());
  }

  void _submitGoogle() {
    final notifier = ref.read(authControllerProvider.notifier);
    PlatformHelper.isMobile
        ? notifier.loginWithGoogleMobile()
        : notifier.loginWithGoogleDesktop();
  }

  @override
  void initState() {
    super.initState();
    if (PlatformHelper.isDesktop) {
      DeepLinkService.onTokenReceived = (token) {
        ref.read(authControllerProvider.notifier).completeGoogleLoginDesktop(token);
      };
      DeepLinkService.onError = (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de Google: $error')),
        );
      };
      DeepLinkService.onTenantSelectionRequired = (ticket, tenants) {
        ref.read(authControllerProvider.notifier).pendingGoogleTenantSelectionDesktop(ticket, tenants);
      };
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    if (PlatformHelper.isDesktop) {
      DeepLinkService.onTokenReceived = null;
      DeepLinkService.onError = null;
      DeepLinkService.onTenantSelectionRequired = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError) {
        final error = next.error;
        String mensaje;
        if (error is DioException && error.response == null) {
          mensaje = 'No se pudo conectar con el servidor.';
        } else if (error is DioException) {
          final errores = ValidationErrors.fromDioException(error);
          mensaje = errores.forField('email') ?? errores.message;
        } else {
          mensaje = 'Ocurrió un error. Intentá de nuevo.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje)),
        );
        return;
      }

      if (next.value != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });

    ref.listen(pendingTenantSelectionProvider, (previous, next) {
      if (next != null && previous == null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SelectBusinessScreen()),
        );
      }
    });

    return Theme(
      data: AppTheme.dark,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 380 : double.infinity),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppLogo(size: isDesktop ? 220 : 170),
                  const SizedBox(height: 8),
                  const Text(
                    'Sistema de Gestión',
                    style: TextStyle(color: AppColors.primaryLight, fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  AppTextField(controller: _emailController, label: 'Email'),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _passwordController,
                    label: 'Contraseña',
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                      ),
                      child: const Text('¿Olvidaste tu contraseña?'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    label: 'Ingresar',
                    onPressed: _submit,
                    loading: authState.isLoading,
                  ),
                  const SizedBox(height: 20),
                  const LoginDivider(),
                  const SizedBox(height: 20),
                  LoginGoogleButton(onPressed: _submitGoogle),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      '¿No tenés cuenta? Registrá tu comercio',
                      style: TextStyle(color: AppColors.primaryLight),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

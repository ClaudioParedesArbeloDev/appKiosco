import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../providers/auth_providers.dart';

/// Pide el email y le avisa al backend que mande el link de reset — la
/// respuesta es siempre la misma exista o no el email (no hay que revelar
/// si una cuenta está registrada), así que acá solo mostramos un mensaje
/// de "listo" genérico.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _enviando = false;
  bool _enviado = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (_emailController.text.trim().isEmpty) return;

    setState(() => _enviando = true);
    try {
      await ref.read(authRepositoryProvider).forgotPassword(_emailController.text.trim());
      if (mounted) setState(() => _enviado = true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo enviar: $e')));
      }
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Theme(
      data: AppTheme.dark,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 380 : double.infinity),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _enviado
                    ? [
                        const Icon(Icons.mark_email_read_outlined, color: AppColors.primaryLight, size: 48),
                        const SizedBox(height: 16),
                        const Text(
                          'Si el correo está registrado, te llegará un enlace para elegir una contraseña nueva.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 24),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Volver a ingresar'),
                        ),
                      ]
                    : [
                        const Text(
                          '¿Olvidaste tu contraseña?',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Escribí tu email y te mandamos un enlace para elegir una nueva.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.primaryLight),
                        ),
                        const SizedBox(height: 24),
                        AppTextField(
                          controller: _emailController,
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(label: 'Enviar enlace', onPressed: _enviar, loading: _enviando),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

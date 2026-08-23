import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../controllers/auth_controller.dart';
import '../../models/tenant_registration_data.dart';
import '../home/home_screen.dart';
import 'widgets/condicion_iva_dropdown.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nombreComercioController = TextEditingController();
  final _titularController = TextEditingController();
  final _rubroController = TextEditingController();
  final _direccionController = TextEditingController();
  final _cuitController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  CondicionIva? _condicionIva;
  ValidationErrors? _errors;

  void _submit() {
    setState(() => _errors = null);

    ref.read(authControllerProvider.notifier).register(
          TenantRegistrationData(
            nombreComercio: _nombreComercioController.text.trim(),
            titular: _titularController.text.trim(),
            rubro: _rubroController.text.trim(),
            direccion: _direccionController.text.trim(),
            cuit: _cuitController.text.trim(),
            condicionIva: _condicionIva ?? CondicionIva.monotributista,
            telefonoContacto: _telefonoController.text.trim(),
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            passwordConfirmation: _passwordConfirmationController.text,
          ),
        );
  }

  @override
  void dispose() {
    _nombreComercioController.dispose();
    _titularController.dispose();
    _rubroController.dispose();
    _direccionController.dispose();
    _cuitController.dispose();
    _telefonoController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      final error = next.error;
      if (error != null) {
        final errors = error is DioException
            ? ValidationErrors.fromDioException(error)
            : const ValidationErrors({}, 'No pudimos crear tu comercio. Probá de nuevo.');

        setState(() => _errors = errors);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errors.message)));
        return;
      }

      if (next.value != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });

    return Theme(
      data: AppTheme.dark,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundDark,
          title: const Text('Registrá tu comercio'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Datos del comercio',
                  style: TextStyle(color: AppColors.primaryLight, fontSize: 14),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _nombreComercioController,
                  label: 'Nombre comercial',
                  errorText: _errors?.forField('nombre_comercio'),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _titularController,
                  label: 'Titular',
                  errorText: _errors?.forField('titular'),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _rubroController,
                  label: 'Rubro (ej: kiosco, ferretería)',
                  errorText: _errors?.forField('rubro'),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _direccionController,
                  label: 'Dirección',
                  errorText: _errors?.forField('direccion'),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _cuitController,
                  label: 'CUIT',
                  keyboardType: TextInputType.number,
                  errorText: _errors?.forField('cuit'),
                ),
                const SizedBox(height: 16),
                CondicionIvaDropdown(
                  value: _condicionIva,
                  onChanged: (value) => setState(() => _condicionIva = value),
                  errorText: _errors?.forField('condicion_iva'),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _telefonoController,
                  label: 'Celular',
                  keyboardType: TextInputType.phone,
                  errorText: _errors?.forField('telefono_contacto'),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Datos de acceso',
                  style: TextStyle(color: AppColors.primaryLight, fontSize: 14),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _nameController,
                  label: 'Tu nombre',
                  errorText: _errors?.forField('name'),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  errorText: _errors?.forField('email'),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  label: 'Contraseña',
                  obscureText: true,
                  errorText: _errors?.forField('password'),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordConfirmationController,
                  label: 'Repetir contraseña',
                  obscureText: true,
                ),
                const SizedBox(height: 28),
                PrimaryButton(
                  label: 'Crear comercio (30 días gratis)',
                  onPressed: _submit,
                  loading: authState.isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

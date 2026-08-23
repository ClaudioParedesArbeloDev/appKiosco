import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../controllers/auth_controller.dart';
import '../../providers/auth_providers.dart';
import '../home/home_screen.dart';

/// Se muestra cuando el mismo mail tiene más de un negocio para esta app
/// (ej. dos kioscos) — el login no alcanza para saber a cuál entrar.
class SelectBusinessScreen extends ConsumerWidget {
  const SelectBusinessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(pendingTenantSelectionProvider);
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError) {
        final error = next.error;
        String mensaje;
        if (error is DioException && error.response == null) {
          mensaje = 'No se pudo conectar con el servidor.';
        } else if (error is DioException) {
          mensaje = ValidationErrors.fromDioException(error).message;
        } else {
          mensaje = 'Ocurrió un error. Intentá de nuevo.';
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
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
          title: const Text('Elegí tu negocio'),
        ),
        body: pending == null
            ? const SizedBox.shrink()
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(24),
                    children: pending.tenants.map((tenant) {
                      return Card(
                        color: AppColors.primaryDark,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(tenant.nombreComercio),
                          trailing: authState.isLoading
                              ? const SizedBox(
                                  width: 20, height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.chevron_right),
                          onTap: authState.isLoading
                              ? null
                              : () => ref.read(authControllerProvider.notifier).selectTenant(tenant.id),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
      ),
    );
  }
}

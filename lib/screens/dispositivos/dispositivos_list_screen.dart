import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../models/dispositivo_model.dart';
import '../../providers/dispositivos_providers.dart';

/// Cajas/mostradores que alguna vez abrieron caja en este comercio. Un
/// dispositivo desactivado no cuenta para el límite de cajas del plan
/// (`max_sucursales`) — pensado para cuando una PC se rompe o se da de
/// baja y hay que liberar su lugar sin perder el historial de ventas que
/// ya generó.
class DispositivosListScreen extends ConsumerWidget {
  const DispositivosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dispositivosAsync = ref.watch(dispositivosListProvider);

    return AppScaffold(
      title: 'Dispositivos',
      body: dispositivosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (dispositivos) => dispositivos.isEmpty
            ? const Center(child: Text('Ningún dispositivo abrió caja todavía'))
            : RefreshIndicator(
                onRefresh: () => ref.refresh(dispositivosListProvider.future),
                child: ListView.separated(
                  itemCount: dispositivos.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) => _DispositivoTile(dispositivo: dispositivos[index]),
                ),
              ),
      ),
    );
  }
}

class _DispositivoTile extends ConsumerWidget {
  const _DispositivoTile({required this.dispositivo});

  final DispositivoModel dispositivo;

  Future<void> _cambiarEstado(WidgetRef ref, BuildContext context) async {
    try {
      final repo = ref.read(dispositivosRepositoryProvider);
      if (dispositivo.activo) {
        await repo.desactivar(dispositivo.id);
      } else {
        await repo.reactivar(dispositivo.id);
      }
      ref.invalidate(dispositivosListProvider);
    } catch (e) {
      if (context.mounted) {
        final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo actualizar: $mensaje')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: dispositivo.activo ? AppColors.accentEmpleados : AppColors.accentPerfil,
        child: Icon(
          dispositivo.activo ? Icons.point_of_sale : Icons.power_off,
          color: AppColors.white,
        ),
      ),
      title: Text(dispositivo.nombre ?? 'Sin nombre'),
      subtitle: Text(
        [
          dispositivo.activo ? 'Activo' : 'Desactivado',
          if (dispositivo.tieneCajaAbierta) 'Caja abierta',
          'Última vez: ${_formatFecha(dispositivo.ultimaVezAt)}',
        ].join(' · '),
      ),
      trailing: TextButton(
        onPressed: dispositivo.tieneCajaAbierta ? null : () => _cambiarEstado(ref, context),
        child: Text(dispositivo.activo ? 'Desactivar' : 'Reactivar'),
      ),
    );
  }

  String _formatFecha(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
  }
}

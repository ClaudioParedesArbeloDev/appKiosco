import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/sync_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/sync_providers.dart';

/// Punto de estado de sincronización — visible en toda la app (vive en
/// `HomeTopBar`). Cubre artículos (tabla editable) y, desde la fase de
/// venta offline, también caja/ventas/clientes hechos sin conexión —
/// contados aparte en `operacionesPendientesCountProvider` porque no son
/// "cambios sin subir" sino "operaciones de negocio esperando su turno".
class SyncStatusIndicator extends ConsumerWidget {
  const SyncStatusIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sync = ref.watch(syncControllerProvider);
    final pendientes = ref.watch(operacionesPendientesCountProvider).value ?? 0;

    final (color, texto) = switch (sync.estado) {
      SyncEstado.sincronizando => (AppColors.warning, 'Sincronizando...'),
      SyncEstado.sinConexion => (AppColors.danger, 'Sin conexión'),
      SyncEstado.error => (AppColors.danger, 'Error al sincronizar: ${sync.error}'),
      SyncEstado.sincronizado => (AppColors.success, 'Sincronizado'),
      SyncEstado.desconocido => (AppColors.primaryLight, 'Iniciando...'),
    };

    final tooltip = pendientes == 0
        ? texto
        : '$texto\n$pendientes operación${pendientes == 1 ? '' : 'es'} sin sincronizar';

    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          if (pendientes > 0) ...[
            const SizedBox(width: 4),
            Text(
              '$pendientes',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
    );
  }
}

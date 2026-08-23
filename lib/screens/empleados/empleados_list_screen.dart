import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../models/empleado_model.dart';
import '../../providers/empleados_providers.dart';
import 'comisiones_screen.dart';
import 'empleado_form_screen.dart';

class EmpleadosListScreen extends ConsumerWidget {
  const EmpleadosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empleadosAsync = ref.watch(empleadosListProvider);
    final userId = ref.watch(authControllerProvider).value?.id;

    return AppScaffold(
      title: 'Empleados',
      section: AppSection.empleados,
      actions: [
        IconButton(
          icon: const Icon(Icons.percent, color: AppColors.white),
          tooltip: 'Comisiones',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ComisionesScreen()),
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const EmpleadoFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
      body: empleadosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (empleados) => empleados.isEmpty
            ? const Center(child: Text('No hay empleados cargados'))
            : RefreshIndicator(
                onRefresh: () => ref.refresh(empleadosListProvider.future),
                child: ListView.separated(
                  itemCount: empleados.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final empleado = empleados[index];
                    return _EmpleadoTile(empleado: empleado, esUnoMismo: empleado.id == userId);
                  },
                ),
              ),
      ),
    );
  }
}

class _EmpleadoTile extends ConsumerWidget {
  const _EmpleadoTile({required this.empleado, required this.esUnoMismo});

  final EmpleadoModel empleado;
  final bool esUnoMismo;

  Future<void> _cambiarRole(WidgetRef ref, BuildContext context, String role) async {
    try {
      await ref.read(empleadosRepositoryProvider).cambiarRole(empleado.id, role);
      ref.invalidate(empleadosListProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo cambiar el rol: $e')));
      }
    }
  }

  Future<void> _cambiarEstado(WidgetRef ref, BuildContext context, String status) async {
    try {
      await ref.read(empleadosRepositoryProvider).cambiarEstado(empleado.id, status);
      ref.invalidate(empleadosListProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo actualizar: $e')));
      }
    }
  }

  Future<void> _editarComision(WidgetRef ref, BuildContext context) async {
    final controller = TextEditingController(
      text: empleado.comisionPorcentaje?.toString() ?? '',
    );

    final resultado = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Comisión sobre sus ventas'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Porcentaje (%)',
            hintText: 'Vacío = sin comisión',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (resultado == null) return;

    try {
      await ref
          .read(empleadosRepositoryProvider)
          .cambiarComision(empleado.id, resultado.isEmpty ? null : int.tryParse(resultado));
      ref.invalidate(empleadosListProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo actualizar: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: empleado.isAdminComercio ? AppColors.primary : AppColors.accentEmpleados,
        child: Icon(
          empleado.isAdminComercio ? Icons.shield : Icons.person,
          color: AppColors.white,
        ),
      ),
      title: Text(empleado.name),
      subtitle: Text(
        '${empleado.email} · ${empleado.isAdminComercio ? 'Administrador' : 'Empleado'}'
        '${empleado.comisionPorcentaje != null ? ' · ${empleado.comisionPorcentaje}% comisión' : ''}'
        '${empleado.activo ? '' : ' · Suspendido'}',
      ),
      trailing: esUnoMismo
          ? const Text('Vos', style: TextStyle(color: AppColors.accentPerfil))
          : PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'hacer_admin':
                    _cambiarRole(ref, context, 'admin_comercio');
                  case 'hacer_empleado':
                    _cambiarRole(ref, context, 'cajero');
                  case 'suspender':
                    _cambiarEstado(ref, context, 'suspended');
                  case 'reactivar':
                    _cambiarEstado(ref, context, 'active');
                  case 'comision':
                    _editarComision(ref, context);
                }
              },
              itemBuilder: (context) => [
                if (empleado.isAdminComercio)
                  const PopupMenuItem(value: 'hacer_empleado', child: Text('Hacer empleado'))
                else
                  const PopupMenuItem(value: 'hacer_admin', child: Text('Hacer administrador')),
                const PopupMenuItem(value: 'comision', child: Text('Editar comisión')),
                if (empleado.activo)
                  const PopupMenuItem(value: 'suspender', child: Text('Suspender'))
                else
                  const PopupMenuItem(value: 'reactivar', child: Text('Reactivar')),
              ],
            ),
    );
  }
}

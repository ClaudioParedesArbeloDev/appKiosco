import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/presupuestos_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/widgets/app_scaffold.dart';
import '../login/login_screen.dart';
import 'presupuesto_detail_screen.dart';
import 'presupuesto_form_screen.dart';
import 'widgets/presupuesto_list_item.dart';

class PresupuestosListScreen extends ConsumerWidget {
  const PresupuestosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presupuestosAsync = ref.watch(presupuestosListProvider);
    final user = ref.watch(authControllerProvider).value;
    final puedeIngresar = user?.hasPermission('ingresar_ventas') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return AppScaffold(
      title: 'Presupuestos',
      section: AppSection.presupuestos,
      floatingActionButton: puedeIngresar
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PresupuestoFormScreen()),
              ),
              child: const Icon(Icons.add),
            )
          : null,
      body: presupuestosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (result) => result.data.isEmpty
            ? const Center(child: Text('Todavía no hay presupuestos'))
            : RefreshIndicator(
                onRefresh: () => ref.refresh(presupuestosListProvider.future),
                child: ListView.separated(
                  itemCount: result.data.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final presupuesto = result.data[index];
                    return PresupuestoListItem(
                      presupuesto: presupuesto,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              PresupuestoDetailScreen(presupuestoId: presupuesto.id),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/proveedores_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/widgets/app_scaffold.dart';
import '../login/login_screen.dart';
import 'proveedor_detail_screen.dart';
import 'proveedor_form_screen.dart';
import 'widgets/proveedor_list_item.dart';

class ProveedoresListScreen extends ConsumerWidget {
  const ProveedoresListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proveedoresAsync = ref.watch(proveedoresListProvider);
    final user = ref.watch(authControllerProvider).value;
    final puedeEditar = user?.hasPermission('modificar_proveedores') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return AppScaffold(
      title: 'Proveedores',
      section: AppSection.proveedores,
      floatingActionButton: puedeEditar
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProveedorFormScreen()),
              ),
              child: const Icon(Icons.add),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final current = ref.read(proveedorFiltrosProvider);
                ref.read(proveedorFiltrosProvider.notifier).update(
                      current.copyWith(search: value),
                    );
              },
            ),
          ),
          Expanded(
            child: proveedoresAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (result) => result.data.isEmpty
                  ? const Center(child: Text('No se encontraron proveedores'))
                  : RefreshIndicator(
                      onRefresh: () => ref.refresh(proveedoresListProvider.future),
                      child: ListView.separated(
                        itemCount: result.data.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final proveedor = result.data[index];
                          return ProveedorListItem(
                            proveedor: proveedor,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProveedorDetailScreen(proveedorId: proveedor.id),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/clientes_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/widgets/app_scaffold.dart';
import '../login/login_screen.dart';
import 'cliente_detail_screen.dart';
import 'cliente_form_screen.dart';
import 'widgets/cliente_list_item.dart';

class ClientesListScreen extends ConsumerWidget {
  const ClientesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientesAsync = ref.watch(clientesListProvider);
    final user = ref.watch(authControllerProvider).value;
    final puedeEditar = user?.hasPermission('modificar_clientes') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return AppScaffold(
      title: 'Clientes',
      section: AppSection.clientes,
      floatingActionButton: puedeEditar
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ClienteFormScreen()),
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
                hintText: 'Buscar por nombre o DNI/CUIT...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final current = ref.read(clienteFiltersProvider);
                ref.read(clienteFiltersProvider.notifier).update(
                      current.copyWith(search: value),
                    );
              },
            ),
          ),
          Expanded(
            child: clientesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (result) => result.data.isEmpty
                  ? const Center(child: Text('No se encontraron clientes'))
                  : RefreshIndicator(
                      onRefresh: () => ref.refresh(clientesListProvider.future),
                      child: ListView.separated(
                        itemCount: result.data.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final cliente = result.data[index];
                          return ClienteListItem(
                            cliente: cliente,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ClienteDetailScreen(clienteId: cliente.id),
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

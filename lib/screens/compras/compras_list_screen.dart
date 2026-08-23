import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/compras_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/widgets/app_scaffold.dart';
import '../login/login_screen.dart';
import 'compra_detail_screen.dart';
import 'compra_form_screen.dart';
import 'widgets/compra_list_item.dart';

class ComprasListScreen extends ConsumerWidget {
  const ComprasListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comprasAsync = ref.watch(comprasListProvider);
    final user = ref.watch(authControllerProvider).value;
    final puedeIngresar = user?.hasPermission('ingresar_compras') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return AppScaffold(
      title: 'Compras',
      section: AppSection.compras,
      floatingActionButton: puedeIngresar
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CompraFormScreen()),
              ),
              child: const Icon(Icons.add),
            )
          : null,
      body: comprasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (result) => result.data.isEmpty
            ? const Center(child: Text('Todavía no hay compras registradas'))
            : RefreshIndicator(
                onRefresh: () => ref.refresh(comprasListProvider.future),
                child: ListView.separated(
                  itemCount: result.data.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final compra = result.data[index];
                    return CompraListItem(
                      compra: compra,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CompraDetailScreen(compraId: compra.id)),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

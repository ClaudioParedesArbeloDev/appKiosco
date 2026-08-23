import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/remitos_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/widgets/app_scaffold.dart';
import '../login/login_screen.dart';
import 'remito_detail_screen.dart';
import 'remito_form_screen.dart';
import 'widgets/remito_list_item.dart';

class RemitosListScreen extends ConsumerWidget {
  const RemitosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remitosAsync = ref.watch(remitosListProvider);
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
      title: 'Remitos',
      section: AppSection.remitos,
      floatingActionButton: puedeIngresar
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RemitoFormScreen()),
              ),
              child: const Icon(Icons.add),
            )
          : null,
      body: remitosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (result) => result.data.isEmpty
            ? const Center(child: Text('Todavía no hay remitos'))
            : RefreshIndicator(
                onRefresh: () => ref.refresh(remitosListProvider.future),
                child: ListView.separated(
                  itemCount: result.data.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final remito = result.data[index];
                    return RemitoListItem(
                      remito: remito,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RemitoDetailScreen(remitoId: remito.id),
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

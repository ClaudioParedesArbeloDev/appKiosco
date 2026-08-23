import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/notas_credito_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/widgets/app_scaffold.dart';
import '../login/login_screen.dart';
import 'widgets/nota_credito_list_item.dart';

class NotasCreditoListScreen extends ConsumerWidget {
  const NotasCreditoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notasCreditoAsync = ref.watch(notasCreditoListProvider);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return AppScaffold(
      title: 'Notas de crédito',
      section: AppSection.notasCredito,
      body: notasCreditoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (result) => result.data.isEmpty
            ? const Center(child: Text('Todavía no hay notas de crédito'))
            : RefreshIndicator(
                onRefresh: () => ref.refresh(notasCreditoListProvider.future),
                child: ListView.separated(
                  itemCount: result.data.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) =>
                      NotaCreditoListItem(notaCredito: result.data[index]),
                ),
              ),
      ),
    );
  }
}

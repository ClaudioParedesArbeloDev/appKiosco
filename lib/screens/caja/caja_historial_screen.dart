import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/caja_controller.dart';
import 'widgets/caja_historial_item.dart';

/// Lista la primera página de cajas pasadas. Igual que otros listados de la
/// app, la paginación real queda pendiente (ver roadmap).
class CajaHistorialScreen extends ConsumerWidget {
  const CajaHistorialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historialAsync = ref.watch(cajaHistorialProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de caja')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(cajaHistorialProvider),
        child: historialAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ListView(
            children: const [
              SizedBox(height: 80),
              Center(child: Text('No pudimos cargar el historial.')),
            ],
          ),
          data: (historial) {
            if (historial.data.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 80),
                  Center(child: Text('Todavía no hay cajas registradas.')),
                ],
              );
            }

            return ListView.separated(
              itemCount: historial.data.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) => CajaHistorialItem(caja: historial.data[index]),
            );
          },
        ),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/notas_credito_controller.dart';
import '../../core/network/validation_errors.dart';
import '../../models/venta_model.dart';
import '../../providers/notas_credito_providers.dart';
import '../../providers/ventas_providers.dart';
import '../../services/notas_credito_repository.dart';

class NotaCreditoFormScreen extends ConsumerStatefulWidget {
  const NotaCreditoFormScreen({super.key, required this.venta});

  final VentaModel venta;

  @override
  ConsumerState<NotaCreditoFormScreen> createState() => _NotaCreditoFormScreenState();
}

class _NotaCreditoFormScreenState extends ConsumerState<NotaCreditoFormScreen> {
  final _motivoController = TextEditingController();
  late final Map<String, int> _cantidadesADevolver = {
    for (final item in widget.venta.items ?? []) item.id: 0,
  };
  bool _guardando = false;

  @override
  void dispose() {
    _motivoController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final items = _cantidadesADevolver.entries
        .where((e) => e.value > 0)
        .map((e) => NotaCreditoItemDraft(ventaItemId: e.key, cantidad: e.value))
        .toList();

    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Indicá al menos una cantidad a devolver')),
      );
      return;
    }
    if (_motivoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Contá el motivo de la devolución')));
      return;
    }

    setState(() => _guardando = true);
    try {
      await ref.read(notasCreditoRepositoryProvider).crear(
            widget.venta.id,
            motivo: _motivoController.text.trim(),
            items: items,
          );

      ref.invalidate(notasCreditoPorVentaProvider(widget.venta.id));
      ref.invalidate(ventaDetailProvider(widget.venta.id));

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Nota de crédito generada')));
      }
    } catch (e) {
      if (mounted) {
        final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo generar: $mensaje')));
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.venta.items ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('Nota de crédito — venta #${widget.venta.numero}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Elegí cuánto devolver de cada artículo:'),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final cantidad = _cantidadesADevolver[item.id] ?? 0;

                  return ListTile(
                    title: Text(item.articuloDescripcion),
                    subtitle: Text('Vendidos: ${item.cantidad}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: cantidad > 0
                              ? () => setState(() => _cantidadesADevolver[item.id] = cantidad - 1)
                              : null,
                        ),
                        Text('$cantidad', style: const TextStyle(fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: cantidad < item.cantidad
                              ? () => setState(() => _cantidadesADevolver[item.id] = cantidad + 1)
                              : null,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: _motivoController,
              decoration: const InputDecoration(
                labelText: 'Motivo de la devolución',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _guardando ? null : _guardar,
                child: _guardando
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Generar nota de crédito', style: TextStyle(fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

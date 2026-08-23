import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/presupuestos_controller.dart';
import '../../core/network/validation_errors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../models/articulo_model.dart';
import '../../models/cliente_model.dart';
import '../../models/item_cantidad_draft.dart';
import '../../providers/presupuestos_providers.dart';
import '../ventas/widgets/articulo_search_field.dart';
import '../ventas/widgets/cliente_selector_field.dart';
import '../ventas/widgets/item_cantidad_dialog.dart';

class PresupuestoFormScreen extends ConsumerStatefulWidget {
  const PresupuestoFormScreen({super.key});

  @override
  ConsumerState<PresupuestoFormScreen> createState() => _PresupuestoFormScreenState();
}

class _PresupuestoFormScreenState extends ConsumerState<PresupuestoFormScreen> {
  final _items = <ItemCantidadDraft>[];
  ClienteModel? _cliente;
  bool _guardando = false;

  int get _total => _items.fold(
        0,
        (suma, item) => suma + item.articulo.precioVigente * item.cantidad,
      );

  Future<void> _agregarArticulo(ArticuloModel articulo) async {
    final draft = await showDialog<ItemCantidadDraft>(
      context: context,
      builder: (_) => ItemCantidadDialog(articulo: articulo),
    );
    if (draft == null) return;

    setState(() {
      final indiceExistente = _items.indexWhere((i) => i.articulo.id == articulo.id);
      if (indiceExistente >= 0) {
        _items[indiceExistente] = draft;
      } else {
        _items.add(draft);
      }
    });
  }

  Future<void> _editarItem(int index) async {
    final draft = await showDialog<ItemCantidadDraft>(
      context: context,
      builder: (_) => ItemCantidadDialog(
        articulo: _items[index].articulo,
        draftExistente: _items[index],
      ),
    );
    if (draft == null) return;
    setState(() => _items[index] = draft);
  }

  Future<void> _guardar() async {
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Agregá al menos un artículo')));
      return;
    }

    setState(() => _guardando = true);
    try {
      await ref.read(presupuestosRepositoryProvider).crear(
            clienteId: _cliente?.id,
            items: _items,
          );

      ref.invalidate(presupuestosListProvider);

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo guardar: $mensaje')));
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Nuevo presupuesto',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClienteSelectorField(
              cliente: _cliente,
              onChanged: (cliente) => setState(() => _cliente = cliente),
            ),
            const SizedBox(height: 16),
            ArticuloSearchField(onSeleccionar: _agregarArticulo),
            const SizedBox(height: 16),
            Expanded(
              child: _items.isEmpty
                  ? const Center(child: Text('Todavía no agregaste artículos'))
                  : ListView.separated(
                      itemCount: _items.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        final subtotal = item.articulo.precioVigente * item.cantidad;
                        return ListTile(
                          title: Text(item.articulo.descripcion),
                          subtitle: Text(
                            '${item.cantidad} x \$${(item.articulo.precioVigente / 100).toStringAsFixed(2)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('\$${(subtotal / 100).toStringAsFixed(2)}'),
                              IconButton(
                                icon: const Icon(Icons.close, size: 20),
                                onPressed: () => setState(() => _items.removeAt(index)),
                              ),
                            ],
                          ),
                          onTap: () => _editarItem(index),
                        );
                      },
                    ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Text(
                  '\$${(_total / 100).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
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
                    : const Text('Guardar presupuesto', style: TextStyle(fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/compras_controller.dart';
import '../../core/network/validation_errors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../models/articulo_model.dart';
import '../../models/compra_item_draft.dart';
import '../../models/proveedor_model.dart';
import '../../providers/compras_providers.dart';
import '../ventas/widgets/articulo_search_field.dart';
import '../ventas/widgets/forma_pago_selector.dart';
import 'widgets/compra_item_dialog.dart';
import 'widgets/proveedor_selector_field.dart';

class CompraFormScreen extends ConsumerStatefulWidget {
  const CompraFormScreen({super.key});

  @override
  ConsumerState<CompraFormScreen> createState() => _CompraFormScreenState();
}

class _CompraFormScreenState extends ConsumerState<CompraFormScreen> {
  final _numeroFacturaController = TextEditingController();
  final _items = <CompraItemDraft>[];

  ProveedorModel? _proveedor;
  String _formaPago = 'efectivo';
  bool _actualizaCosto = true;
  bool _guardando = false;

  int get _total => _items.fold(0, (suma, item) => suma + item.subtotal);

  @override
  void dispose() {
    _numeroFacturaController.dispose();
    super.dispose();
  }

  Future<void> _agregarArticulo(ArticuloModel articulo) async {
    final draft = await showDialog<CompraItemDraft>(
      context: context,
      builder: (_) => CompraItemDialog(articulo: articulo),
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
    final draft = await showDialog<CompraItemDraft>(
      context: context,
      builder: (_) => CompraItemDialog(
        articulo: _items[index].articulo,
        draftExistente: _items[index],
      ),
    );
    if (draft == null) return;
    setState(() => _items[index] = draft);
  }

  Future<void> _guardar() async {
    if (_proveedor == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Elegí un proveedor')));
      return;
    }
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Agregá al menos un artículo')));
      return;
    }

    setState(() => _guardando = true);

    try {
      await ref.read(comprasRepositoryProvider).crear(
            proveedorId: _proveedor!.id,
            formaPago: _formaPago,
            items: _items,
            actualizaCosto: _actualizaCosto,
            numeroFactura: _numeroFacturaController.text.trim(),
          );

      ref.invalidate(comprasListProvider);

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
      title: 'Nueva compra',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProveedorSelectorField(
              proveedor: _proveedor,
              onChanged: (proveedor) => setState(() => _proveedor = proveedor),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _numeroFacturaController,
              decoration: const InputDecoration(
                labelText: 'Número de factura (opcional)',
                border: OutlineInputBorder(),
              ),
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
                        return ListTile(
                          title: Text(item.articulo.descripcion),
                          subtitle: Text(
                            '${item.cantidad} x \$${(item.precioUnitario / 100).toStringAsFixed(2)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('\$${(item.subtotal / 100).toStringAsFixed(2)}'),
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
            FormaPagoSelector(
              value: _formaPago,
              onChanged: (value) => setState(() => _formaPago = value),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Actualizar costo de los artículos'),
              value: _actualizaCosto,
              onChanged: (value) => setState(() => _actualizaCosto = value),
            ),
            const SizedBox(height: 8),
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
                    : const Text('Registrar compra', style: TextStyle(fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

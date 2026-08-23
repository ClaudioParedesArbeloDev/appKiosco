import 'package:flutter/material.dart';
import '../../../models/articulo_model.dart';
import '../../../models/item_cantidad_draft.dart';

class ItemCantidadDialog extends StatefulWidget {
  const ItemCantidadDialog({super.key, required this.articulo, this.draftExistente});

  final ArticuloModel articulo;
  final ItemCantidadDraft? draftExistente;

  @override
  State<ItemCantidadDialog> createState() => _ItemCantidadDialogState();
}

class _ItemCantidadDialogState extends State<ItemCantidadDialog> {
  late final _cantidadController = TextEditingController(
    text: (widget.draftExistente?.cantidad ?? 1).toString(),
  );

  @override
  void dispose() {
    _cantidadController.dispose();
    super.dispose();
  }

  void _confirmar() {
    final cantidad = int.tryParse(_cantidadController.text.trim());
    if (cantidad == null || cantidad < 1) return;

    Navigator.of(context).pop(ItemCantidadDraft(articulo: widget.articulo, cantidad: cantidad));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.articulo.descripcion),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Precio: \$${(widget.articulo.precioVigente / 100).toStringAsFixed(2)}'),
          const SizedBox(height: 16),
          TextField(
            controller: _cantidadController,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'Cantidad', border: OutlineInputBorder()),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
        FilledButton(onPressed: _confirmar, child: const Text('Agregar')),
      ],
    );
  }
}

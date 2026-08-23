import 'package:flutter/material.dart';
import '../../../models/articulo_model.dart';
import '../../../models/compra_item_draft.dart';

/// Pide cantidad y precio unitario para un artículo de la compra — el
/// precio lo escribe el usuario (es lo que cobró el proveedor), a
/// diferencia de una venta donde el precio nunca viene del cliente.
class CompraItemDialog extends StatefulWidget {
  const CompraItemDialog({super.key, required this.articulo, this.draftExistente});

  final ArticuloModel articulo;
  final CompraItemDraft? draftExistente;

  @override
  State<CompraItemDialog> createState() => _CompraItemDialogState();
}

class _CompraItemDialogState extends State<CompraItemDialog> {
  late final _cantidadController = TextEditingController(
    text: (widget.draftExistente?.cantidad ?? 1).toString(),
  );
  late final _precioController = TextEditingController(
    text: ((widget.draftExistente?.precioUnitario ?? widget.articulo.precioCosto) / 100)
        .toStringAsFixed(2),
  );

  @override
  void dispose() {
    _cantidadController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  void _confirmar() {
    final cantidad = int.tryParse(_cantidadController.text.trim());
    final precio = double.tryParse(_precioController.text.trim().replaceAll(',', '.'));

    if (cantidad == null || cantidad < 1 || precio == null || precio < 0) return;

    Navigator.of(context).pop(
      CompraItemDraft(
        articulo: widget.articulo,
        cantidad: cantidad,
        precioUnitario: (precio * 100).round(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.articulo.descripcion),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _cantidadController,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'Cantidad', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _precioController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Precio unitario',
              prefixText: '\$ ',
              border: OutlineInputBorder(),
            ),
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

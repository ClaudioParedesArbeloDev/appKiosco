import 'package:flutter/material.dart';

class AjustarStockDialog extends StatefulWidget {
  const AjustarStockDialog({super.key});

  @override
  State<AjustarStockDialog> createState() => _AjustarStockDialogState();
}

class _AjustarStockDialogState extends State<AjustarStockDialog> {
  final _cantidadController = TextEditingController();
  final _notaController = TextEditingController();
  bool _esEntrada = true;

  @override
  void dispose() {
    _cantidadController.dispose();
    _notaController.dispose();
    super.dispose();
  }

  void _confirmar() {
    final cantidad = int.tryParse(_cantidadController.text);
    if (cantidad == null || cantidad <= 0 || _notaController.text.trim().isEmpty) {
      return;
    }

    Navigator.of(context).pop((
      cantidad: _esEntrada ? cantidad : -cantidad,
      nota: _notaController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajustar stock'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Entrada')),
              ButtonSegment(value: false, label: Text('Salida')),
            ],
            selected: {_esEntrada},
            onSelectionChanged: (value) => setState(() => _esEntrada = value.first),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _cantidadController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cantidad', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notaController,
            decoration: const InputDecoration(
              labelText: 'Motivo (obligatorio)',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
        FilledButton(onPressed: _confirmar, child: const Text('Confirmar')),
      ],
    );
  }
}

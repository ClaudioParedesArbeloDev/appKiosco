import 'package:flutter/material.dart';

/// Pide tipo (ingreso/retiro), monto y nota para un movimiento manual de
/// caja. Devuelve un record con esos datos, o null si se cancela.
class MovimientoDialog extends StatefulWidget {
  const MovimientoDialog({super.key});

  @override
  State<MovimientoDialog> createState() => _MovimientoDialogState();
}

class _MovimientoDialogState extends State<MovimientoDialog> {
  final _montoController = TextEditingController();
  final _notaController = TextEditingController();
  bool _esIngreso = true;

  @override
  void dispose() {
    _montoController.dispose();
    _notaController.dispose();
    super.dispose();
  }

  void _confirmar() {
    final monto = double.tryParse(_montoController.text.replaceAll(',', '.'));
    if (monto == null || monto <= 0 || _notaController.text.trim().isEmpty) {
      return;
    }

    Navigator.of(context).pop((
      tipo: _esIngreso ? 'ingreso' : 'retiro',
      monto: (monto * 100).round(),
      nota: _notaController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar movimiento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Ingreso')),
              ButtonSegment(value: false, label: Text('Retiro')),
            ],
            selected: {_esIngreso},
            onSelectionChanged: (value) => setState(() => _esIngreso = value.first),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _montoController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Monto',
              prefixText: '\$ ',
              border: OutlineInputBorder(),
            ),
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

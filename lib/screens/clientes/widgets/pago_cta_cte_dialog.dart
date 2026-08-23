import 'package:flutter/material.dart';

/// Pide monto (en pesos) y forma de pago para registrar un cobro de cuenta
/// corriente. Devuelve `(monto en centavos, formaPago, nota)` con
/// `Navigator.pop`, o null si se cancela.
class PagoCtaCteDialog extends StatefulWidget {
  const PagoCtaCteDialog({super.key});

  @override
  State<PagoCtaCteDialog> createState() => _PagoCtaCteDialogState();
}

class _PagoCtaCteDialogState extends State<PagoCtaCteDialog> {
  final _montoController = TextEditingController();
  final _notaController = TextEditingController();
  String _formaPago = 'efectivo';

  @override
  void dispose() {
    _montoController.dispose();
    _notaController.dispose();
    super.dispose();
  }

  void _confirmar() {
    final monto = double.tryParse(_montoController.text.replaceAll(',', '.'));
    if (monto == null || monto <= 0) return;

    Navigator.of(context).pop((
      monto: (monto * 100).round(),
      formaPago: _formaPago,
      nota: _notaController.text.trim().isEmpty ? null : _notaController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar pago'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _montoController,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Monto',
              prefixText: '\$ ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'efectivo', label: Text('Efectivo')),
              ButtonSegment(value: 'tarjeta', label: Text('Tarjeta')),
            ],
            selected: {_formaPago},
            onSelectionChanged: (selected) => setState(() => _formaPago = selected.first),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notaController,
            decoration: const InputDecoration(
              labelText: 'Nota (opcional)',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
        FilledButton(onPressed: _confirmar, child: const Text('Registrar')),
      ],
    );
  }
}

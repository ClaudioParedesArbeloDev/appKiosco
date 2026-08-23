import 'package:flutter/material.dart';
import '../../../models/caja_resumen_model.dart';

/// Pide el monto final contado (en pesos) para cerrar la caja. Muestra el
/// total esperado en efectivo como referencia, pero el arqueo (diferencia)
/// lo calcula el backend, nunca el cliente. Devuelve el monto en centavos
/// con `Navigator.pop`, o null si se cancela.
class CerrarCajaDialog extends StatefulWidget {
  const CerrarCajaDialog({super.key, required this.resumen});

  /// Null cuando se está cerrando sin conexión — el server es quien calcula
  /// el total esperado real (puede incluir movimientos que pasaron online
  /// antes de cortarse la conexión), así que no mostramos una referencia
  /// que podría estar incompleta.
  final CajaResumenModel? resumen;

  @override
  State<CerrarCajaDialog> createState() => _CerrarCajaDialogState();
}

class _CerrarCajaDialogState extends State<CerrarCajaDialog> {
  final _montoController = TextEditingController();

  @override
  void dispose() {
    _montoController.dispose();
    super.dispose();
  }

  void _confirmar() {
    final monto = double.tryParse(_montoController.text.replaceAll(',', '.'));
    if (monto == null || monto < 0) return;

    Navigator.of(context).pop((monto * 100).round());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cerrar caja'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.resumen == null
                ? 'Sin conexión: el total esperado se calcula al sincronizar.'
                : 'Efectivo esperado: \$${widget.resumen!.totalEfectivoPesos.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _montoController,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Monto final contado',
              prefixText: '\$ ',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
        FilledButton(onPressed: _confirmar, child: const Text('Cerrar caja')),
      ],
    );
  }
}

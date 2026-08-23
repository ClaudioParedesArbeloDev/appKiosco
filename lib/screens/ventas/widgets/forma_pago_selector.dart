import 'package:flutter/material.dart';

class FormaPagoSelector extends StatelessWidget {
  const FormaPagoSelector({super.key, required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  static const _opciones = {
    'efectivo': 'Efectivo',
    'tarjeta': 'Tarjeta',
    'cuenta_corriente': 'Cuenta corriente',
  };

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      style: SegmentedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      segments: _opciones.entries
          .map((e) => ButtonSegment(value: e.key, label: Text(e.value)))
          .toList(),
      selected: {value},
      onSelectionChanged: (selected) => onChanged(selected.first),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../models/nota_credito_model.dart';

class NotaCreditoListItem extends StatelessWidget {
  const NotaCreditoListItem({super.key, required this.notaCredito});

  final NotaCreditoModel notaCredito;

  String _formatFecha(DateTime? fecha) {
    if (fecha == null) return '-';
    return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('NC #${notaCredito.numero} — venta #${notaCredito.ventaNumero ?? "-"}'),
      subtitle: Text('${_formatFecha(notaCredito.createdAt)} · ${notaCredito.motivo}'),
      trailing: Text(
        '-\$${notaCredito.totalPesos.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

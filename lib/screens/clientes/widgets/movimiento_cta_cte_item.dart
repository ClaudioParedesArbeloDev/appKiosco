import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/cuenta_corriente_movimiento_model.dart';

class MovimientoCtaCteItem extends StatelessWidget {
  const MovimientoCtaCteItem({super.key, required this.movimiento});

  final CuentaCorrienteMovimientoModel movimiento;

  String _formatFecha(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
  }

  String get _titulo => switch (movimiento.tipo) {
        'venta' => 'Venta a cuenta corriente',
        'pago' => 'Pago',
        _ => 'Ajuste',
      };

  @override
  Widget build(BuildContext context) {
    final aumentaDeuda = movimiento.monto > 0;

    return ListTile(
      title: Text(_titulo),
      subtitle: Text(
        [
          _formatFecha(movimiento.createdAt),
          if (movimiento.usuarioNombre != null) movimiento.usuarioNombre!,
          if (movimiento.nota != null) movimiento.nota!,
        ].join(' · '),
      ),
      trailing: Text(
        '${aumentaDeuda ? '+' : ''}\$${movimiento.montoPesos.toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: aumentaDeuda ? AppColors.danger : AppColors.success,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/movimiento_stock_model.dart';

class MovimientoStockItem extends StatelessWidget {
  const MovimientoStockItem({super.key, required this.movimiento});

  final MovimientoStockModel movimiento;

  String _fecha(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final color = movimiento.esEntrada ? AppColors.success : AppColors.danger;
    final signo = movimiento.esEntrada ? '+' : '';

    return ListTile(
      leading: Icon(
        movimiento.esEntrada ? Icons.arrow_downward : Icons.arrow_upward,
        color: color,
      ),
      title: Text('$signo${movimiento.cantidad} · ${movimiento.motivo}'),
      subtitle: Text(
        [
          _fecha(movimiento.createdAt),
          if (movimiento.usuarioNombre != null) movimiento.usuarioNombre!,
          if (movimiento.nota != null) movimiento.nota!,
        ].join(' · '),
      ),
    );
  }
}

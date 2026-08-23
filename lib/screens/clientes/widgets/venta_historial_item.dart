import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/venta_model.dart';

class VentaHistorialItem extends StatelessWidget {
  const VentaHistorialItem({super.key, required this.venta, this.onTap});

  final VentaModel venta;
  final VoidCallback? onTap;

  String _fecha(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        venta.estaAnulada ? Icons.cancel_outlined : Icons.receipt_long,
        color: venta.estaAnulada ? AppColors.danger : AppColors.success,
      ),
      title: Text('Venta #${venta.numero} · \$${venta.totalPesos.toStringAsFixed(2)}'),
      subtitle: Text(
        [
          _fecha(venta.createdAt),
          venta.formaPago,
          if (venta.estaAnulada) 'Anulada',
        ].join(' · '),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/compra_model.dart';

const _formasPagoCompra = {
  'efectivo': 'Efectivo',
  'tarjeta': 'Tarjeta',
  'cuenta_corriente': 'Cuenta corriente',
};

class CompraListItem extends StatelessWidget {
  const CompraListItem({super.key, required this.compra, required this.onTap});

  final CompraModel compra;
  final VoidCallback onTap;

  String _formatFecha(DateTime? fecha) {
    if (fecha == null) return '-';
    return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(compra.proveedorNombre ?? 'Compra'),
      subtitle: Text(
        [
          _formatFecha(compra.createdAt),
          _formasPagoCompra[compra.formaPago] ?? compra.formaPago,
          if (compra.numeroFactura != null) 'Fact. ${compra.numeroFactura}',
        ].join(' · '),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${compra.totalPesos.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (compra.estaAnulada)
            const Text('Anulada', style: TextStyle(color: AppColors.danger, fontSize: 12)),
        ],
      ),
    );
  }
}

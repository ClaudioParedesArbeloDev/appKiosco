import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/articulo_model.dart';

class ArticuloListItem extends StatelessWidget {
  const ArticuloListItem({super.key, required this.articulo, required this.onTap});

  final ArticuloModel articulo;
  final VoidCallback onTap;

  Color _stockColor(int? stock) {
    if (stock == null) return Colors.grey;
    if (stock <= 0) return AppColors.danger;
    if (stock < 5) return AppColors.warning;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    final stock = articulo.stockActual;

    return ListTile(
      onTap: onTap,
      title: Text(articulo.descripcion),
      subtitle: Text(
        [
          if (articulo.marca != null) articulo.marca!,
          if (articulo.promocionVigente)
            '\$${articulo.precioVentaPesos.toStringAsFixed(2)} → \$${articulo.precioVigentePesos.toStringAsFixed(2)}'
          else
            '\$${articulo.precioVentaPesos.toStringAsFixed(2)}',
        ].join(' · '),
        style: articulo.promocionVigente
            ? const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)
            : null,
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: _stockColor(stock).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Stock: ${stock ?? '-'}',
          style: TextStyle(color: _stockColor(stock), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/remito_model.dart';

const _estadosRemito = {
  'vigente': 'Vigente',
  'convertido': 'Convertido',
  'anulado': 'Anulado',
};

class RemitoListItem extends StatelessWidget {
  const RemitoListItem({super.key, required this.remito, required this.onTap});

  final RemitoModel remito;
  final VoidCallback onTap;

  String _formatFecha(DateTime? fecha) {
    if (fecha == null) return '-';
    return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
  }

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'convertido':
        return AppColors.success;
      case 'anulado':
        return AppColors.danger;
      default:
        return AppColors.accentRemitos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text('Remito #${remito.numero}'),
      subtitle: Text(_formatFecha(remito.createdAt)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${remito.totalPesos.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            _estadosRemito[remito.estado] ?? remito.estado,
            style: TextStyle(color: _colorEstado(remito.estado), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

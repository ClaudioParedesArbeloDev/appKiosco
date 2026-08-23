import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/presupuesto_model.dart';

const _estadosPresupuesto = {
  'vigente': 'Vigente',
  'convertido': 'Convertido',
  'anulado': 'Anulado',
};

class PresupuestoListItem extends StatelessWidget {
  const PresupuestoListItem({super.key, required this.presupuesto, required this.onTap});

  final PresupuestoModel presupuesto;
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
        return AppColors.accentPresupuestos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text('Presupuesto #${presupuesto.numero}'),
      subtitle: Text(_formatFecha(presupuesto.createdAt)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${presupuesto.totalPesos.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            _estadosPresupuesto[presupuesto.estado] ?? presupuesto.estado,
            style: TextStyle(color: _colorEstado(presupuesto.estado), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

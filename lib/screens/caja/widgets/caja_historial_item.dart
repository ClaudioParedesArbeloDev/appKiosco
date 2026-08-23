import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/caja_model.dart';

class CajaHistorialItem extends StatelessWidget {
  const CajaHistorialItem({super.key, required this.caja});

  final CajaModel caja;

  String _formatFecha(DateTime? fecha) {
    if (fecha == null) return '-';
    return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year} '
        '${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}';
  }

  Color _colorDiferencia(int? diferencia) {
    if (diferencia == null || diferencia == 0) return AppColors.success;
    return diferencia > 0 ? AppColors.warning : AppColors.danger;
  }

  @override
  Widget build(BuildContext context) {
    final cerrada = !caja.estaAbierta;

    return ListTile(
      title: Text(
        cerrada ? 'Cerrada — ${_formatFecha(caja.cerradaAt)}' : 'Abierta',
      ),
      subtitle: Text(
        [
          if (caja.nombreDispositivo != null) caja.nombreDispositivo!,
          if (caja.usuarioNombre != null) caja.usuarioNombre!,
          'Inicial: \$${caja.montoInicialPesos.toStringAsFixed(2)}',
        ].join(' · '),
      ),
      trailing: cerrada
          ? Text(
              '\$${caja.diferenciaPesos.toStringAsFixed(2)}',
              style: TextStyle(
                color: _colorDiferencia(caja.diferencia),
                fontWeight: FontWeight.bold,
              ),
            )
          : const Icon(Icons.circle, color: AppColors.success, size: 12),
    );
  }
}

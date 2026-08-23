import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/cliente_model.dart';

class ClienteListItem extends StatelessWidget {
  const ClienteListItem({super.key, required this.cliente, required this.onTap});

  final ClienteModel cliente;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(cliente.nombre),
      subtitle: Text(
        [
          condicionesIva[cliente.condicionIva] ?? cliente.condicionIva,
          if (cliente.zona != null) cliente.zona!,
          if (cliente.porcentajeDescuento > 0) '${cliente.porcentajeDescuento}% desc.',
        ].join(' · '),
      ),
      trailing: cliente.activo
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Inactivo',
                style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}

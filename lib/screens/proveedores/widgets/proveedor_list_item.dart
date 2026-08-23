import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/proveedor_model.dart';

class ProveedorListItem extends StatelessWidget {
  const ProveedorListItem({super.key, required this.proveedor, required this.onTap});

  final ProveedorModel proveedor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(proveedor.nombre),
      subtitle: Text(
        [
          if (proveedor.cuit != null) proveedor.cuit!,
          if (proveedor.telefono != null) proveedor.telefono!,
        ].join(' · '),
      ),
      trailing: proveedor.activo
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

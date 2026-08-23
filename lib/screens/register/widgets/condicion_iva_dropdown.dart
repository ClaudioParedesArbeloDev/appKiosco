import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/tenant_registration_data.dart';

class CondicionIvaDropdown extends StatelessWidget {
  const CondicionIvaDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  final CondicionIva? value;
  final ValueChanged<CondicionIva?> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CondicionIva>(
      initialValue: value,
      onChanged: onChanged,
      dropdownColor: AppColors.backgroundDark,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        labelText: 'Condición frente al IVA',
        errorText: errorText,
        border: const OutlineInputBorder(),
      ),
      items: CondicionIva.values
          .map((c) => DropdownMenuItem(value: c, child: Text(c.label)))
          .toList(),
    );
  }
}

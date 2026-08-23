import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: AppColors.primaryLight)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('o'),
        ),
        Expanded(child: Divider(color: AppColors.primaryLight)),
      ],
    );
  }
}

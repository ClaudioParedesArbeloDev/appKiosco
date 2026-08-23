import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SplashLoadingIndicator extends StatelessWidget {
  const SplashLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 28,
      height: 28,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation(AppColors.primaryLight),
      ),
    );
  }
}

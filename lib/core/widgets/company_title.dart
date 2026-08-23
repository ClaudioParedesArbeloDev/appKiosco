import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Lockup de marca: ícono + "CODE & LENS solutions". Reemplaza al logo
/// completo rasterizado en splash/login (tamaño grande) y puede usarse
/// también chico en headers/topbars — por eso los tamaños son parámetros.
class CompanyTitle extends StatelessWidget {
  const CompanyTitle({
    super.key,
    this.iconSize = 25,
    this.fontSize = 14,
    this.showWordmark = true,
  });

  final double iconSize;
  final double fontSize;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    final icon = Image.asset('assets/images/logo.png', height: iconSize, width: iconSize);
    if (!showWordmark) return icon;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: iconSize * 0.4),
          Text(
            'CODE & LENS',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: fontSize,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(width: iconSize * 0.4),
          Text(
            'solutions',
            style: TextStyle(
              fontFamily: 'FiraCode',
              fontSize: fontSize,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
              letterSpacing: 5,
            ),
          ),
        ],
      ),
    );
  }
}

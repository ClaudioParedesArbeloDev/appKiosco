import 'package:flutter/material.dart';
import '../../../core/widgets/company_title.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CompanyTitle(iconSize: size * 0.25, fontSize: size * 0.075);
  }
}

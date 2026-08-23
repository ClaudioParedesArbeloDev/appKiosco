import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Avatar del usuario logueado: la foto si tiene una (Google), si no las
/// iniciales del nombre sobre un círculo de color.
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.name, this.avatarUrl, this.radius = 20});

  final String name;
  final String? avatarUrl;
  final double radius;

  String get _iniciales {
    final partes = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (partes.isEmpty) return '?';
    if (partes.length == 1) return partes.first[0].toUpperCase();
    return (partes.first[0] + partes.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.primaryLight,
        backgroundImage: NetworkImage(avatarUrl!),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary,
      child: Text(
        _iniciales,
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: radius * 0.8,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryDark,
          brightness: Brightness.dark,
          primary: AppColors.primaryLight,
          secondary: AppColors.primary,
        ),
        textTheme: const TextTheme(bodyLarge: TextStyle(color: AppColors.white)),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: AppColors.primaryLight),
          hintStyle: TextStyle(color: AppColors.primaryLight.withValues(alpha: 0.6)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryLight),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white),
          ),
        ),
      );
}
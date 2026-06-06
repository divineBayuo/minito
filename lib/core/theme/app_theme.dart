// produces themedata for both light and dark
// uses material 3 with a custom colorscheme derived
// from appcolors

import 'package:flutter/material.dart';
import 'package:minito/core/theme/app_colors.dart';

abstract class AppTheme {
  static ThemeData light() => _build(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimary,
    ),
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark,
      brightness: Brightness.dark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
    ),
  );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme colorScheme,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,

      // typography
      // use system default fonts; override specific styles below
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(height: 1.6),
        bodyMedium: TextStyle(height: 1.5),
      ),

      // cards
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        color: brightness == Brightness.light
            ? AppColors.cardLight
            : AppColors.cardDark,
      ),

      // appbar
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: brightness == Brightness.light
            ? AppColors.surfaceLight
            : AppColors.surfaceDark,
        foregroundColor: brightness == Brightness.light
            ? AppColors.textPrimary
            : AppColors.textPrimaryDark,
      ),

      // navigation bar
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 64,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // filled buttons
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),

      // input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

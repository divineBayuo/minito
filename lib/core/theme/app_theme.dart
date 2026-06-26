import 'package:flutter/material.dart';

class AppTheme {
  static const _black = Color(0xFF000000);
  static const _white = Color(0xFFFFFFFF);
  static const _grey = Color(0xFF7F7F7F);
  static const _orange = Color(0xFFF58A07);
  static const _yellow = Color(0xFFF7CB15);

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: _orange,
        secondary: _yellow,
        onPrimary: _white,
        onSecondary: _black,
        surface: _white,
        onSurface: _black,
        surfaceContainerLowest: const Color(0xFFF5F5F5),
        surfaceContainerHigh: const Color(0xFFEBEBEB),
        onSurfaceVariant: _grey,
        outline: const Color(0xFFD0D0D0),
        outlineVariant: const Color(0xFFE0E0E0),
        error: const Color(0xFFD32F2F),
      ),
      fontFamily: 'Bricolage Grotesque'
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: _orange,
        secondary: _yellow,
        onPrimary: _white,
        onSecondary: _black,
        surface: const Color(0xFF1A1A1A),
        onSurface: _white,
        surfaceContainerLowest: const Color(0xFF111111),
        surfaceContainerHigh: const Color(0xFF2A2A2A),
        onSurfaceVariant: _grey,
        outline: const Color(0xFF3A3A3A),
        outlineVariant: const Color(0xFF2E2E2E),
        error: const Color(0xFFEF5350),
      ),
      fontFamily: 'Bricolage Grotesque'
    );
  }
}
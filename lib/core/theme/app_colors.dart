import 'package:flutter/material.dart';

/// Color tokens mirrored from alterday-web/src/shared/colors.ts
abstract final class AppColors {
  // Dark theme
  static const darkBackground = Color(0xFF0F1117);
  static const darkSurface = Color(0xFF1A2E2E);
  static const darkAccent = Color(0xFF00E5C3);

  // Light theme
  static const lightBackground = Color(0xFFF5F7F7);
  static const lightSurface = Color(0xFFD6EEEB);
  static const lightAccent = Color(0xFF00967D);

  // Foreground — dark theme
  static const darkOnBackground = Color(0xFFF5F7F7);
  static const darkOnSurface = Color(0xFFD6EEEB);
  static const darkOnAccent = Color(0xFF0F1117);

  // Foreground — light theme
  static const lightOnBackground = Color(0xFF0F1117);
  static const lightOnSurface = Color(0xFF1A2E2E);
  static const lightOnAccent = Color(0xFFF5F7F7);

  // Semantic
  static const destructive = Color(0xFFE53E3E);
  static const warning = Color(0xFFD97706);
  static const success = Color(0xFF00967D);

  // Extra
  static const gridScanLightAccent = Color(0xFF2AAA8A);
}

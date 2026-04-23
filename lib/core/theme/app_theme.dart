import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        background: AppColors.darkBackground,
        surface: AppColors.darkSurface,
        accent: AppColors.darkAccent,
        onBackground: AppColors.darkOnBackground,
        onSurface: AppColors.darkOnSurface,
        onAccent: AppColors.darkOnAccent,
      );

  static ThemeData get light => _build(
        brightness: Brightness.light,
        background: AppColors.lightBackground,
        surface: AppColors.lightSurface,
        accent: AppColors.lightAccent,
        onBackground: AppColors.lightOnBackground,
        onSurface: AppColors.lightOnSurface,
        onAccent: AppColors.lightOnAccent,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color accent,
    required Color onBackground,
    required Color onSurface,
    required Color onAccent,
  }) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accent,
        onPrimary: onAccent,
        secondary: accent,
        onSecondary: onAccent,
        surface: surface,
        onSurface: onSurface,
        error: AppColors.destructive,
        onError: Colors.white,
      ),
      textTheme: _textTheme(onBackground),
      inputDecorationTheme: _inputTheme(surface, accent, onSurface),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: onAccent,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'GeistMono',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: onSurface,
          side: BorderSide(color: onSurface.withValues(alpha: 0.3)),
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'GeistMono',
            fontSize: 13,
          ),
        ),
      ),
      useMaterial3: true,
    );
  }

  static TextTheme _textTheme(Color onBackground) => TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Syne',
          fontSize: 48,
          fontWeight: FontWeight.w800,
          color: onBackground,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Syne',
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: onBackground,
          height: 1.2,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Syne',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: onBackground,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Syne',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: onBackground,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'GeistMono',
          fontSize: 15,
          color: onBackground,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'GeistMono',
          fontSize: 13,
          color: onBackground.withValues(alpha: 0.7),
        ),
        labelLarge: TextStyle(
          fontFamily: 'GeistMono',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: onBackground,
        ),
        labelSmall: TextStyle(
          fontFamily: 'GeistMono',
          fontSize: 11,
          letterSpacing: 1.5,
          color: onBackground.withValues(alpha: 0.5),
        ),
      );

  static InputDecorationTheme _inputTheme(
    Color surface,
    Color accent,
    Color onSurface,
  ) =>
      InputDecorationTheme(
        filled: true,
        fillColor: surface.withValues(alpha: 0.6),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: onSurface.withValues(alpha: 0.15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: onSurface.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.destructive),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.destructive, width: 1.5),
        ),
        labelStyle: TextStyle(
          fontFamily: 'GeistMono',
          fontSize: 12,
          letterSpacing: 1.0,
          color: onSurface.withValues(alpha: 0.6),
        ),
        hintStyle: TextStyle(
          fontFamily: 'GeistMono',
          fontSize: 13,
          color: onSurface.withValues(alpha: 0.4),
        ),
      );
}

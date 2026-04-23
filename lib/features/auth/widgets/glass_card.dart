import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          decoration: BoxDecoration(
            color: surface.withValues(alpha: isDark ? 0.8 : 0.9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accent.withValues(alpha: isDark ? 0.2 : 0.3)),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.12),
                      blurRadius: 40,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: child,
        ),
      ),
    );
  }
}

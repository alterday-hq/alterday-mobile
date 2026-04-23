import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/providers/locale_provider.dart';

class AuthTopBar extends ConsumerWidget {
  const AuthTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final fg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final locale = ref.watch(localeProvider);
    final lang = locale.languageCode.toUpperCase();

    final pillDecoration = BoxDecoration(
      color: surface.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: accent.withValues(alpha: 0.2)),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => ref.read(localeProvider.notifier).toggle(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: pillDecoration,
            child: Text(
              lang,
              style: TextStyle(
                fontFamily: 'GeistMono',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => ref.read(themeProvider.notifier).toggle(),
          child: Container(
            width: 36,
            height: 36,
            decoration: pillDecoration,
            child: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              size: 16,
              color: fg,
            ),
          ),
        ),
      ],
    );
  }
}

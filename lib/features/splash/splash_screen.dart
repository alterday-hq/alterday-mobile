import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../auth/providers/auth_provider.dart';
import '../../core/theme/app_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _navigated = false;
  // Controls the fade-out overlay before navigation
  bool _fadingOut = false;

  @override
  void initState() {
    super.initState();
    _scheduleNavigation();
  }

  Future<void> _scheduleNavigation() async {
    // Hold after all animations complete (~1700ms), then fade out
    await Future.delayed(const Duration(milliseconds: 3200));
    if (!mounted || _navigated) return;
    setState(() => _fadingOut = true);

    // Fade out duration = 500ms, then navigate
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted || _navigated) return;
    _navigated = true;
    final session = ref.read(authStateProvider).asData?.value.session;
    final isAuthed = session != null && session.user.emailConfirmedAt != null;
    if (mounted) context.go(isAuthed ? '/home' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final wordmark = isDark
        ? 'assets/logo/logo-day-text-dark.svg'
        : 'assets/logo/logo-day-text-light.svg';

    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    // All proportions derived from original 1024×1024 logo canvas:
    // Wordmark: 855×230, at y=105..335
    // Gap:      49px
    // Symbol:   1024×640, at y=384..1024
    final scale = screenWidth / 1024;
    final symbolSize = screenWidth;
    final symbolHeight = 640 * scale;
    final halfWidth = screenWidth / 2;
    final wordmarkWidth = 855 * scale;
    final wordmarkHeight = 230 * scale;
    final gap = 49 * scale;

    // Center the full composition vertically
    final compositionHeight = wordmarkHeight + gap + symbolHeight;
    final wordmarkTop = (screenHeight - compositionHeight) / 2;
    final symbolTop = wordmarkTop + wordmarkHeight + gap;

    return Scaffold(
      backgroundColor: bg,
      body: AnimatedOpacity(
        opacity: _fadingOut ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        child: Stack(
          children: [
            // ── Symbol glow по контурах — проявляється при з'єднанні (1000ms) ──
            Positioned(
              top: symbolTop,
              left: 0,
              right: 0,
              child:
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: SvgPicture.asset(
                      'assets/logo/logo-symbol-dark.svg',
                      width: symbolSize,
                      height: symbolHeight,
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        accent.withValues(alpha: 0.55),
                        BlendMode.srcIn,
                      ),
                    ),
                  ).animate().fadeIn(
                    delay: 1000.ms,
                    duration: 700.ms,
                    curve: Curves.easeOut,
                  ),
            ),

            // ── Symbol left half ──
            _SymbolHalf(
              accent: accent,
              isLeft: true,
              topOffset: symbolTop,
              symbolSize: symbolSize,
              symbolHeight: symbolHeight,
              halfWidth: halfWidth,
            ),

            // ── Symbol right half ──
            _SymbolHalf(
              accent: accent,
              isLeft: false,
              topOffset: symbolTop,
              symbolSize: symbolSize,
              symbolHeight: symbolHeight,
              halfWidth: halfWidth,
            ),

            // ── Wordmark з text glow (cascade: 150ms після symbol glow) ──
            Positioned(
              top: wordmarkTop,
              left: 0,
              right: 0,
              child: Center(
                child: _Wordmark(
                  assetPath: wordmark,
                  width: wordmarkWidth,
                  glowColor: accent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Wordmark: текст з'являється → потім glow
// Cascade: text at 800ms, glow at 1150ms (+150ms після symbol glow)
// ─────────────────────────────────────────────
class _Wordmark extends StatelessWidget {
  const _Wordmark({
    required this.assetPath,
    required this.width,
    required this.glowColor,
  });

  final String assetPath;
  final double width;
  final Color glowColor;

  @override
  Widget build(BuildContext context) {
    final glowLayer = ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: SvgPicture.asset(
        assetPath,
        width: width,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(
          glowColor.withValues(alpha: 0.7),
          BlendMode.srcIn,
        ),
      ),
    ).animate().fadeIn(delay: 1150.ms, duration: 500.ms, curve: Curves.easeOut);

    final textLayer = SvgPicture.asset(
      assetPath,
      width: width,
      fit: BoxFit.contain,
    ).animate().fadeIn(delay: 800.ms, duration: 600.ms, curve: Curves.easeOut);

    return Stack(alignment: Alignment.center, children: [glowLayer, textLayer]);
  }
}

// ─────────────────────────────────────────────
// Одна половина символу
// ─────────────────────────────────────────────
class _SymbolHalf extends StatelessWidget {
  const _SymbolHalf({
    required this.accent,
    required this.isLeft,
    required this.topOffset,
    required this.symbolSize,
    required this.symbolHeight,
    required this.halfWidth,
  });

  final Color accent;
  final bool isLeft;
  final double topOffset;
  final double symbolSize;
  final double symbolHeight;
  final double halfWidth;

  @override
  Widget build(BuildContext context) {
    final svg = SvgPicture.asset(
      'assets/logo/logo-symbol-dark.svg',
      width: symbolSize,
      height: symbolHeight,
      fit: BoxFit.fill,
      colorFilter: ColorFilter.mode(accent, BlendMode.srcIn),
    );

    final clippedHalf = ClipRect(
      child: SizedBox(
        width: halfWidth,
        height: symbolHeight,
        child: OverflowBox(
          alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          minWidth: symbolSize,
          maxWidth: symbolSize,
          minHeight: symbolHeight,
          maxHeight: symbolHeight,
          child: svg,
        ),
      ),
    );

    return Positioned(
      top: topOffset,
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      width: halfWidth,
      height: symbolHeight,
      child: clippedHalf.animate(
        effects: [
          FadeEffect(begin: 0, end: 1, duration: 400.ms),
          SlideEffect(
            begin: isLeft ? const Offset(-1.0, 2.8) : const Offset(1.0, 2.8),
            end: Offset.zero,
            duration: 1000.ms,
            curve: Curves.easeOutCubic,
          ),
        ],
      ),
    );
  }
}

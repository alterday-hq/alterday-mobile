import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GridScanBackground extends StatefulWidget {
  const GridScanBackground({super.key, required this.child});

  final Widget child;

  @override
  State<GridScanBackground> createState() => _GridScanBackgroundState();
}

class _GridScanBackgroundState extends State<GridScanBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 25000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final lineColor = isDark ? AppColors.darkAccent : AppColors.lightAccent;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => CustomPaint(
        painter: _CorridorPainter(
          bg: bg,
          lineColor: lineColor,
          isDark: isDark,
          t: _controller.value,
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}

class _CorridorPainter extends CustomPainter {
  const _CorridorPainter({
    required this.bg,
    required this.lineColor,
    required this.isDark,
    required this.t,
  });

  final Color bg;
  final Color lineColor;
  final bool isDark;
  final double t;

  static const _numRings = 14;
  static const _numDivisionsTopBottom = 8;
  static const _numDivisionsLeftRight = 14;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = bg,
    );

    final vp = Offset(size.width / 2, size.height / 2);
    _drawRadialLines(canvas, size, vp);
    _drawRings(canvas, size, vp);
    _drawVignette(canvas, size);
  }

  // Lines radiating from vanishing point to all screen edges
  void _drawRadialLines(Canvas canvas, Size size, Offset vp) {
    final paint = Paint()
      ..color = lineColor.withValues(alpha: isDark ? 0.30 : 0.50)
      ..strokeWidth = 1.0;

    for (int i = 0; i <= _numDivisionsTopBottom; i++) {
      final f = i / _numDivisionsTopBottom;
      canvas.drawLine(vp, Offset(size.width * f, 0), paint);
      canvas.drawLine(vp, Offset(size.width * f, size.height), paint);
    }
    for (int i = 0; i <= _numDivisionsLeftRight; i++) {
      final f = i / _numDivisionsLeftRight;
      canvas.drawLine(vp, Offset(0, size.height * f), paint);
      canvas.drawLine(vp, Offset(size.width, size.height * f), paint);
    }
  }

  // Rectangular rings flying toward the viewer
  void _drawRings(Canvas canvas, Size size, Offset vp) {
    for (int i = 0; i < _numRings; i++) {
      final d = ((i / _numRings) + t) % 1.0;

      // Smoothstep — rings accelerate as they approach (natural perspective)
      final curved = d * d * (3.0 - 2.0 * d);

      final halfW = curved * (size.width / 2);
      final halfH = curved * (size.height / 2);

      if (halfW < 2 || halfH < 2) continue;

      // Fade in from center, fade out near edges — so rings emerge from void
      final alpha = math.sin(d * math.pi) * (isDark ? 0.85 : 0.60);

      canvas.drawRect(
        Rect.fromCenter(center: vp, width: halfW * 2, height: halfH * 2),
        Paint()
          ..color = lineColor.withValues(alpha: alpha.clamp(0.0, 1.0))
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
      );
    }
  }

  void _drawVignette(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [Colors.transparent, bg.withValues(alpha: 0.75)],
          stops: const [0.45, 1.0],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  @override
  bool shouldRepaint(_CorridorPainter old) =>
      old.t != t || old.isDark != isDark;
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class OAuthButtons extends StatelessWidget {
  const OAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final fg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;

    final buttonStyle = OutlinedButton.styleFrom(
      backgroundColor: bg.withValues(alpha: 0.5),
      foregroundColor: fg,
      side: BorderSide(color: accent.withValues(alpha: 0.15)),
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: const TextStyle(fontFamily: 'GeistMono', fontSize: 14, fontWeight: FontWeight.w500),
    );

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            style: buttonStyle,
            icon: _GitHubIcon(color: fg),
            label: const Text('GitHub'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            style: buttonStyle,
            icon: const _GoogleIcon(),
            label: Text('Google', style: TextStyle(color: fg)),
          ),
        ),
      ],
    );
  }
}

class _GitHubIcon extends StatelessWidget {
  const _GitHubIcon({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(16, 16), painter: _GitHubPainter(color));
  }
}

class _GitHubPainter extends CustomPainter {
  const _GitHubPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    final s = size.width / 24;
    path.addPath(
      Path()
        ..moveTo(12 * s, 2 * s)
        ..cubicTo(6.477 * s, 2 * s, 2 * s, 6.484 * s, 2 * s, 12.017 * s)
        ..cubicTo(2 * s, 16.442 * s, 4.865 * s, 20.197 * s, 8.839 * s, 21.521 * s)
        ..cubicTo(9.339 * s, 21.613 * s, 9.521 * s, 21.304 * s, 9.521 * s, 21.038 * s)
        ..cubicTo(9.521 * s, 20.801 * s, 9.513 * s, 20.17 * s, 9.508 * s, 19.335 * s)
        ..cubicTo(6.726 * s, 19.94 * s, 6.139 * s, 18.597 * s, 6.139 * s, 18.597 * s)
        ..cubicTo(5.685 * s, 17.439 * s, 5.029 * s, 17.131 * s, 5.029 * s, 17.131 * s)
        ..cubicTo(4.121 * s, 16.511 * s, 5.098 * s, 16.523 * s, 5.098 * s, 16.523 * s)
        ..cubicTo(6.101 * s, 16.593 * s, 6.629 * s, 17.555 * s, 6.629 * s, 17.555 * s)
        ..cubicTo(7.521 * s, 19.085 * s, 8.97 * s, 18.643 * s, 9.539 * s, 18.387 * s)
        ..cubicTo(9.631 * s, 17.74 * s, 9.889 * s, 17.299 * s, 10.175 * s, 17.049 * s)
        ..cubicTo(7.955 * s, 16.796 * s, 5.62 * s, 15.936 * s, 5.62 * s, 12.098 * s)
        ..cubicTo(5.62 * s, 11.005 * s, 6.01 * s, 10.11 * s, 6.649 * s, 9.41 * s)
        ..cubicTo(6.546 * s, 9.157 * s, 6.203 * s, 8.138 * s, 6.747 * s, 6.76 * s)
        ..cubicTo(6.747 * s, 6.76 * s, 7.587 * s, 6.49 * s, 9.497 * s, 7.786 * s)
        ..cubicTo(10.302 * s, 7.568 * s, 11.157 * s, 7.457 * s, 12.006 * s, 7.453 * s)
        ..cubicTo(12.856 * s, 7.457 * s, 13.711 * s, 7.568 * s, 14.51 * s, 7.786 * s)
        ..cubicTo(16.419 * s, 6.49 * s, 17.257 * s, 6.76 * s, 17.257 * s, 6.76 * s)
        ..cubicTo(17.803 * s, 8.139 * s, 17.459 * s, 9.158 * s, 17.357 * s, 9.41 * s)
        ..cubicTo(17.997 * s, 10.11 * s, 18.385 * s, 11.005 * s, 18.385 * s, 12.098 * s)
        ..cubicTo(18.385 * s, 15.946 * s, 16.046 * s, 16.793 * s, 13.82 * s, 17.041 * s)
        ..cubicTo(14.179 * s, 17.35 * s, 14.498 * s, 17.961 * s, 14.498 * s, 18.896 * s)
        ..cubicTo(14.498 * s, 20.234 * s, 14.486 * s, 21.315 * s, 14.486 * s, 21.643 * s)
        ..cubicTo(14.486 * s, 21.911 * s, 14.666 * s, 22.223 * s, 15.174 * s, 22.125 * s)
        ..cubicTo(19.135 * s, 20.797 * s, 22 * s, 17.044 * s, 22 * s, 12.017 * s)
        ..cubicTo(22 * s, 6.484 * s, 17.522 * s, 2 * s, 12 * s, 2 * s)
        ..close(),
      Offset.zero,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_GitHubPainter old) => old.color != color;
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24;

    void drawPath(String color, List<List<double>> points) {
      final paint = Paint()
        ..color = Color(int.parse('0xFF${color.substring(1)}'))
        ..style = PaintingStyle.fill;
      final path = Path()
        ..moveTo(points[0][0] * s, points[0][1] * s);
      for (final p in points.skip(1)) {
        if (p.length == 2) {
          path.lineTo(p[0] * s, p[1] * s);
        } else {
          path.cubicTo(p[0] * s, p[1] * s, p[2] * s, p[3] * s, p[4] * s, p[5] * s);
        }
      }
      path.close();
      canvas.drawPath(path, paint);
    }

    drawPath('#4285F4', [[22.56, 12.25], [22.36, 10], [12, 10], [12, 14.26], [17.92, 14.26], [15.71, 17.57], [15.71, 17.57], [15.71, 20.34], [19.28, 20.34], [21.36, 18.42], [21.36, 18.42], [22.56, 12.25]]);
    drawPath('#34A853', [[12, 23], [19.28, 20.34], [15.71, 17.57], [14.73, 18.23], [13.29, 18.63], [10.43, 18.63], [4.27, 14.1], [2.18, 14.1], [2.18, 16.94], [3.99, 20.53], [12, 23]]);
    drawPath('#FBBC05', [[5.84, 14.09], [5.49, 13.43], [5.49, 12], [5.49, 10.57], [5.84, 9.91], [5.84, 9.91], [2.18, 7.07], [1, 10.22], [1, 12], [1.43, 13.45], [2.18, 14.93], [5.84, 14.09]]);
    drawPath('#EA4335', [[12, 5.38], [16.21, 7.02], [19.36, 3.87], [17.45, 2.09], [14.97, 1], [12, 1], [7.7, 1], [3.99, 3.47], [2.18, 7.07], [5.84, 9.91], [12, 5.38]]);
  }

  @override
  bool shouldRepaint(_GooglePainter old) => false;
}

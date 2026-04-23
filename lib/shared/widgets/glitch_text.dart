import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GlitchText extends StatefulWidget {
  const GlitchText(
    this.text, {
    super.key,
    this.style,
    this.speed = 1.0,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final double speed;
  final TextAlign? textAlign;

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText> {
  static const _pool = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#\$%^&*';
  final _rng = Random();
  late String _displayed;
  Timer? _cycleTimer;
  Timer? _restoreTimer;

  @override
  void initState() {
    super.initState();
    _displayed = widget.text;
    _startCycle();
  }

  void _startCycle() {
    final intervalMs = (3000 / widget.speed).round();
    _cycleTimer = Timer.periodic(Duration(milliseconds: intervalMs), (_) => _glitch());
  }

  void _glitch() {
    final result = widget.text.split('').map((c) {
      if (c == ' ') return ' ';
      return _rng.nextDouble() < 0.3 ? _pool[_rng.nextInt(_pool.length)] : c;
    }).join();
    if (mounted) setState(() => _displayed = result);
    _restoreTimer = Timer(const Duration(milliseconds: 160), () {
      if (mounted) setState(() => _displayed = widget.text);
    });
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    _restoreTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayed, style: widget.style, textAlign: widget.textAlign);
  }
}

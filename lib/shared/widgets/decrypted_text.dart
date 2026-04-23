import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class DecryptedText extends StatefulWidget {
  const DecryptedText(
    this.text, {
    super.key,
    this.style,
    this.speed = 30,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final int speed;
  final TextAlign? textAlign;

  @override
  State<DecryptedText> createState() => _DecryptedTextState();
}

class _DecryptedTextState extends State<DecryptedText> {
  static const _pool = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#\$%^&*';
  final _rng = Random();
  late List<String> _chars;
  int _revealed = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _start(widget.text);
  }

  @override
  void didUpdateWidget(DecryptedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _timer?.cancel();
      _revealed = 0;
      _start(widget.text);
    }
  }

  void _start(String text) {
    _chars = text.split('').map((c) {
      return c == ' ' ? ' ' : _pool[_rng.nextInt(_pool.length)];
    }).toList();
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (_) {
      if (_revealed >= _chars.length || _revealed >= widget.text.length) {
        _timer?.cancel();
        return;
      }
      setState(() {
        _chars[_revealed] = widget.text[_revealed];
        _revealed++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_chars.join(), style: widget.style, textAlign: widget.textAlign);
  }
}

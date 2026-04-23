import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/decrypted_text.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.prefixIcon,
    this.controller,
    this.obscure = false,
    this.onToggleObscure,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
  });

  final String label;
  final String placeholder;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final bool obscure;
  final VoidCallback? onToggleObscure;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final fg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecryptedText(
          label.toUpperCase(),
          speed: 80,
          style: TextStyle(
            fontFamily: 'GeistMono',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
            color: fg.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          textInputAction: textInputAction,
          style: TextStyle(fontSize: 14, color: fg),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: fg.withValues(alpha: 0.3), fontSize: 14),
            prefixIcon: Icon(prefixIcon, size: 16, color: accent.withValues(alpha: 0.5)),
            suffixIcon: onToggleObscure != null
                ? IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 16,
                      color: accent.withValues(alpha: 0.5),
                    ),
                    onPressed: onToggleObscure,
                  )
                : null,
            filled: true,
            fillColor: bg.withValues(alpha: 0.6),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accent.withValues(alpha: 0.15)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accent.withValues(alpha: 0.15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accent.withValues(alpha: 0.6), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

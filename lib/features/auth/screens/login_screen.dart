import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/glitch_text.dart';
import '../../../shared/widgets/decrypted_text.dart';
import '../widgets/glass_card.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/oauth_buttons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final fg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = fg.withValues(alpha: 0.5);
    final wordmark = isDark
        ? 'assets/logo/logo-day-text-dark.svg'
        : 'assets/logo/logo-day-text-light.svg';
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    const AuthTopBar(),
                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GlitchText(
                        l.authLoginTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'GeistMono',
                          fontSize: 52,
                          fontWeight: FontWeight.w900,
                          color: fg,
                          height: 1,
                        ),
                      ),
                    ),

                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: SvgPicture.asset(wordmark, width: 160, fit: BoxFit.contain),
                          ),
                          const SizedBox(height: 16),

                          Center(
                            child: DecryptedText(
                              key: ValueKey(l.authLoginSubtitle),
                              l.authLoginSubtitle,
                              speed: 28,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'GeistMono',
                                fontSize: 13,
                                color: muted,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          AuthField(
                            label: l.authLoginEmailLabel,
                            placeholder: l.authLoginEmailPlaceholder,
                            prefixIcon: Icons.alternate_email,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),

                          AuthField(
                            label: l.authLoginPasswordLabel,
                            placeholder: l.authLoginPasswordPlaceholder,
                            prefixIcon: Icons.lock_outline,
                            controller: _passwordController,
                            obscure: _obscurePassword,
                            onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                            autofillHints: const [AutofillHints.password],
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 8),

                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                l.authLoginForgotPassword,
                                style: TextStyle(
                                  fontFamily: 'GeistMono',
                                  fontSize: 12,
                                  color: accent.withValues(alpha: 0.6),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          ElevatedButton(
                            onPressed: () {},
                            child: Text(l.authLoginSubmit),
                          ),
                          const SizedBox(height: 20),

                          _AuthDivider(label: l.authLoginOrContinueWith, accent: accent),
                          const SizedBox(height: 16),

                          const OAuthButtons(),
                          const SizedBox(height: 20),

                          Column(
                            children: [
                              Text(
                                l.authLoginNoAccount,
                                style: TextStyle(
                                  fontFamily: 'GeistMono',
                                  fontSize: 12,
                                  color: muted,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => context.go('/register'),
                                child: Text(
                                  l.authLoginSignUp,
                                  style: TextStyle(
                                    fontFamily: 'GeistMono',
                                    fontSize: 12,
                                    color: accent.withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthDivider extends StatelessWidget {
  const _AuthDivider({required this.label, required this.accent});
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final line = Expanded(child: Divider(color: accent.withValues(alpha: 0.15), thickness: 1));
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: 'GeistMono',
              fontSize: 10,
              letterSpacing: 1.5,
              color: accent.withValues(alpha: 0.4),
            ),
          ),
        ),
        line,
      ],
    );
  }
}

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

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _subjectController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _subjectController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
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
                        l.authRegisterTitle,
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
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: SvgPicture.asset(wordmark, width: 160, fit: BoxFit.contain),
                          ),
                          const SizedBox(height: 12),

                          Center(
                            child: DecryptedText(
                              key: ValueKey(l.authRegisterSubtitle1),
                              l.authRegisterSubtitle1,
                              speed: 28,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'GeistMono',
                                fontSize: 13,
                                color: muted,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Center(
                            child: DecryptedText(
                              key: ValueKey(l.authRegisterSubtitle2),
                              l.authRegisterSubtitle2,
                              speed: 28,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'GeistMono',
                                fontSize: 13,
                                color: muted,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),

                          AuthField(
                            label: l.authRegisterSubjectLabel,
                            placeholder: l.authRegisterSubjectPlaceholder,
                            prefixIcon: Icons.person_outline,
                            controller: _subjectController,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),

                          AuthField(
                            label: l.authRegisterEmailLabel,
                            placeholder: l.authRegisterEmailPlaceholder,
                            prefixIcon: Icons.alternate_email,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),

                          AuthField(
                            label: l.authRegisterPasswordLabel,
                            placeholder: l.authRegisterPasswordPlaceholder,
                            prefixIcon: Icons.lock_outline,
                            controller: _passwordController,
                            obscure: _obscurePassword,
                            onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                            autofillHints: const [AutofillHints.newPassword],
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),

                          AuthField(
                            label: l.authRegisterConfirmLabel,
                            placeholder: l.authRegisterConfirmPlaceholder,
                            prefixIcon: Icons.lock_outline,
                            controller: _confirmController,
                            obscure: _obscureConfirm,
                            onToggleObscure: () => setState(() => _obscureConfirm = !_obscureConfirm),
                            autofillHints: const [AutofillHints.newPassword],
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 20),

                          ElevatedButton(
                            onPressed: () {},
                            child: Text(l.authRegisterSubmit),
                          ),
                          const SizedBox(height: 20),

                          _AuthDivider(label: l.authRegisterOrContinueWith, accent: accent),
                          const SizedBox(height: 16),

                          const OAuthButtons(),
                          const SizedBox(height: 20),

                          Column(
                            children: [
                              Text(
                                l.authRegisterHasAccount,
                                style: TextStyle(
                                  fontFamily: 'GeistMono',
                                  fontSize: 12,
                                  color: muted,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => context.go('/login'),
                                child: Text(
                                  l.authRegisterSignIn,
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

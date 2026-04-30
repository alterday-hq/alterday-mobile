import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/config/app_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/glitch_text.dart';
import '../../../shared/widgets/decrypted_text.dart';
import '../widgets/glass_card.dart';
import '../widgets/auth_field.dart';
import '../../../shared/widgets/grid_scan_background.dart';
import '../widgets/oauth_buttons.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _subjectController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _termsAccepted = false;
  bool _termsInvalid = false;
  late final AnimationController _shakeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );
  late final Animation<double> _shakeAnimation = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 8.0, end: -5.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -5.0, end: 5.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 5.0, end: 0.0), weight: 1),
  ]).animate(_shakeController);

  @override
  void dispose() {
    _subjectController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final fg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = fg.withValues(alpha: 0.5);
    final wordmark = isDark
        ? 'assets/logo/logo-day-text-dark.svg'
        : 'assets/logo/logo-day-text-light.svg';
    final l = AppLocalizations.of(context)!;

    return GridScanBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
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
                          const SizedBox(height: 16),

                          // Terms & Privacy consent
                          AnimatedBuilder(
                            animation: _shakeAnimation,
                            builder: (context, child) => Transform.translate(
                              offset: Offset(_shakeAnimation.value, 0),
                              child: child,
                            ),
                            child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => setState(() {
                                  _termsAccepted = !_termsAccepted;
                                  if (_termsAccepted) _termsInvalid = false;
                                }),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: _termsAccepted ? accent : Colors.transparent,
                                    border: Border.all(
                                      color: _termsInvalid
                                          ? Colors.red.withValues(alpha: 0.6)
                                          : _termsAccepted
                                              ? accent
                                              : accent.withValues(alpha: 0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: _termsAccepted
                                      ? Icon(Icons.check, size: 11, color: isDark ? AppColors.darkBackground : AppColors.lightBackground)
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(fontFamily: 'GeistMono', fontSize: 10, color: muted, height: 1.4),
                                    children: [
                                      TextSpan(text: l.authRegisterTermsConsent),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: GestureDetector(
                                          onTap: () => launchUrl(Uri.parse(AppConfig.termsUrl), mode: LaunchMode.externalApplication),
                                          child: Text(l.authRegisterTermsLink, style: TextStyle(fontFamily: 'GeistMono', fontSize: 10, color: accent.withValues(alpha: 0.7), decoration: TextDecoration.underline, decorationColor: accent.withValues(alpha: 0.4))),
                                        ),
                                      ),
                                      TextSpan(text: l.authRegisterTermsAnd),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: GestureDetector(
                                          onTap: () => launchUrl(Uri.parse(AppConfig.privacyUrl), mode: LaunchMode.externalApplication),
                                          child: Text(l.authRegisterPrivacyLink, style: TextStyle(fontFamily: 'GeistMono', fontSize: 10, color: accent.withValues(alpha: 0.7), decoration: TextDecoration.underline, decorationColor: accent.withValues(alpha: 0.4))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ),

                          const SizedBox(height: 16),

                          ElevatedButton(
                            onPressed: () {
                              if (!_termsAccepted) {
                                setState(() => _termsInvalid = true);
                                _shakeController.forward(from: 0);
                                return;
                              }
                              // TODO(jacek): wire up signUp logic
                            },
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

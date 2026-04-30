// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get authLoginTitle => 'Login';

  @override
  String get authLoginSubtitle =>
      'Enter your credentials to begin the synchronization process.';

  @override
  String get authLoginEmailLabel => 'Digital Address';

  @override
  String get authLoginEmailPlaceholder => 'user@network.sys';

  @override
  String get authLoginPasswordLabel => 'Access Key';

  @override
  String get authLoginPasswordPlaceholder => '••••••••';

  @override
  String get authLoginForgotPassword => 'Key recovery protocol →';

  @override
  String get authLoginSubmit => 'Establish Connection';

  @override
  String get authLoginOrContinueWith => 'alternative authentication';

  @override
  String get authLoginNoAccount => 'Not registered in the system?';

  @override
  String get authLoginSignUp => 'Initialize Account';

  @override
  String get authRegisterTitle => 'Register';

  @override
  String get authRegisterHeadline1 => 'Quantify';

  @override
  String get authRegisterHeadline2 => 'every';

  @override
  String get authRegisterHeadline3 => 'alternate';

  @override
  String get authRegisterHeadline4 => 'possibility.';

  @override
  String get authRegisterSubtitle1 => 'Start your simulation.';

  @override
  String get authRegisterSubtitle2 => 'Create your identity in the system.';

  @override
  String get authRegisterSubjectLabel => 'Subject Name';

  @override
  String get authRegisterSubjectPlaceholder => 'subject_name';

  @override
  String get authRegisterEmailLabel => 'Digital Address';

  @override
  String get authRegisterEmailPlaceholder => 'user@network.sys';

  @override
  String get authRegisterPasswordLabel => 'Access Key';

  @override
  String get authRegisterPasswordPlaceholder => '••••••••';

  @override
  String get authRegisterConfirmLabel => 'Verify Access Key';

  @override
  String get authRegisterConfirmPlaceholder => '••••••••';

  @override
  String get authRegisterSubmit => 'Initialize Account';

  @override
  String get authRegisterOrContinueWith => 'alternative authentication';

  @override
  String get authRegisterHasAccount => 'Already in the system?';

  @override
  String get authRegisterSignIn => 'Establish Connection';

  @override
  String get authRegisterStatsJoined => 'identities initialized';

  @override
  String get commonShowPassword => 'Reveal access key';

  @override
  String get commonHidePassword => 'Conceal access key';

  @override
  String get commonToggleTheme => 'Toggle theme';

  @override
  String get commonSwitchLanguage => 'Switch language';

  @override
  String get authRegisterTermsConsent => 'I agree to the ';

  @override
  String get authRegisterTermsLink => 'Terms of Service';

  @override
  String get authRegisterTermsAnd => ' and ';

  @override
  String get authRegisterPrivacyLink => 'Privacy Policy';

  @override
  String get authRegisterTermsError => 'You must accept the terms to continue';
}

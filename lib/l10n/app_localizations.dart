import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLoginTitle;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to begin the synchronization process.'**
  String get authLoginSubtitle;

  /// No description provided for @authLoginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Digital Address'**
  String get authLoginEmailLabel;

  /// No description provided for @authLoginEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'user@network.sys'**
  String get authLoginEmailPlaceholder;

  /// No description provided for @authLoginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Access Key'**
  String get authLoginPasswordLabel;

  /// No description provided for @authLoginPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get authLoginPasswordPlaceholder;

  /// No description provided for @authLoginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Key recovery protocol →'**
  String get authLoginForgotPassword;

  /// No description provided for @authLoginSubmit.
  ///
  /// In en, this message translates to:
  /// **'Establish Connection'**
  String get authLoginSubmit;

  /// No description provided for @authLoginOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'alternative authentication'**
  String get authLoginOrContinueWith;

  /// No description provided for @authLoginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Not registered in the system?'**
  String get authLoginNoAccount;

  /// No description provided for @authLoginSignUp.
  ///
  /// In en, this message translates to:
  /// **'Initialize Account'**
  String get authLoginSignUp;

  /// No description provided for @authRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegisterTitle;

  /// No description provided for @authRegisterHeadline1.
  ///
  /// In en, this message translates to:
  /// **'Quantify'**
  String get authRegisterHeadline1;

  /// No description provided for @authRegisterHeadline2.
  ///
  /// In en, this message translates to:
  /// **'every'**
  String get authRegisterHeadline2;

  /// No description provided for @authRegisterHeadline3.
  ///
  /// In en, this message translates to:
  /// **'alternate'**
  String get authRegisterHeadline3;

  /// No description provided for @authRegisterHeadline4.
  ///
  /// In en, this message translates to:
  /// **'possibility.'**
  String get authRegisterHeadline4;

  /// No description provided for @authRegisterSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Start your simulation.'**
  String get authRegisterSubtitle1;

  /// No description provided for @authRegisterSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Create your identity in the system.'**
  String get authRegisterSubtitle2;

  /// No description provided for @authRegisterSubjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject Name'**
  String get authRegisterSubjectLabel;

  /// No description provided for @authRegisterSubjectPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'subject_name'**
  String get authRegisterSubjectPlaceholder;

  /// No description provided for @authRegisterEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Digital Address'**
  String get authRegisterEmailLabel;

  /// No description provided for @authRegisterEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'user@network.sys'**
  String get authRegisterEmailPlaceholder;

  /// No description provided for @authRegisterPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Access Key'**
  String get authRegisterPasswordLabel;

  /// No description provided for @authRegisterPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get authRegisterPasswordPlaceholder;

  /// No description provided for @authRegisterConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Verify Access Key'**
  String get authRegisterConfirmLabel;

  /// No description provided for @authRegisterConfirmPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get authRegisterConfirmPlaceholder;

  /// No description provided for @authRegisterSubmit.
  ///
  /// In en, this message translates to:
  /// **'Initialize Account'**
  String get authRegisterSubmit;

  /// No description provided for @authRegisterOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'alternative authentication'**
  String get authRegisterOrContinueWith;

  /// No description provided for @authRegisterHasAccount.
  ///
  /// In en, this message translates to:
  /// **'Already in the system?'**
  String get authRegisterHasAccount;

  /// No description provided for @authRegisterSignIn.
  ///
  /// In en, this message translates to:
  /// **'Establish Connection'**
  String get authRegisterSignIn;

  /// No description provided for @authRegisterStatsJoined.
  ///
  /// In en, this message translates to:
  /// **'identities initialized'**
  String get authRegisterStatsJoined;

  /// No description provided for @commonShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Reveal access key'**
  String get commonShowPassword;

  /// No description provided for @commonHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Conceal access key'**
  String get commonHidePassword;

  /// No description provided for @commonToggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get commonToggleTheme;

  /// No description provided for @commonSwitchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get commonSwitchLanguage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

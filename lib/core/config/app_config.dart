abstract final class AppConfig {
  static const String webBaseUrl = String.fromEnvironment(
    'WEB_BASE_URL',
    defaultValue: 'https://alterday.app',
  );

  static String get termsUrl => '$webBaseUrl/terms';
  static String get privacyUrl => '$webBaseUrl/privacy';
}

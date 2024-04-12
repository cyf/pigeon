import 'package:homing_pigeon/i18n/i18n.dart';

class LocaleUtil {
  static String defaultLanguageCode = 'en';

  static String withLanguageCode(String? languageCode) {
    final supportedLocales = AppLocaleUtils.supportedLocales
        .map((locale) => locale.languageCode)
        .toList();

    if (languageCode == null) return defaultLanguageCode;

    return supportedLocales.contains(languageCode)
        ? languageCode
        : defaultLanguageCode;
  }
}

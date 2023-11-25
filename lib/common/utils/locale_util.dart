import 'package:homing_pigeon/l10n/l10n.dart';

class LocaleUtil {
  static String defaultLanguageCode = 'en';

  static String withLanguageCode(String? languageCode) {
    final supportedLocales = AppLocalizations.supportedLocales
        .map((locale) => locale.languageCode)
        .toList();

    if (languageCode == null) return defaultLanguageCode;

    return supportedLocales.contains(languageCode)
        ? languageCode
        : defaultLanguageCode;
  }
}

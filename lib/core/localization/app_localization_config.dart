import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// App localization configuration
class AppLocalizationConfig {
  /// Supported locales
  static const List<Locale> supportedLocales = [
    Locale('ar'), // Arabic first
    Locale('en'), // English second
  ];

  /// Default locale
  static const Locale defaultLocale = Locale('ar');

  /// Fallback locale
  static const Locale fallbackLocale = Locale('ar');

  /// Translations path
  static const String translationsPath = 'assets/translations';

  /// Initialize localization
  static Future<void> initialize() async {
    await EasyLocalization.ensureInitialized();
  }

  /// Get EasyLocalization widget
  static Widget getLocalizationWidget({required Widget child}) {
    return EasyLocalization(
      supportedLocales: supportedLocales,
      path: translationsPath,
      fallbackLocale: fallbackLocale,
      startLocale: defaultLocale, // Force Arabic as start locale
      child: child,
    );
  }

  /// Get MaterialApp localization delegates
  static List<LocalizationsDelegate<dynamic>> getLocalizationDelegates(BuildContext context) {
    return context.localizationDelegates;
  }

  /// Get supported locales
  static List<Locale> getSupportedLocales(BuildContext context) {
    return context.supportedLocales;
  }

  /// Get current locale
  static Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  /// Set locale
  static Future<void> setLocale(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }

  /// Check if locale is supported
  static bool isLocaleSupported(Locale locale) {
    return supportedLocales.any((supportedLocale) => 
        supportedLocale.languageCode == locale.languageCode);
  }

  /// Get locale by language code
  static Locale? getLocaleByLanguageCode(String languageCode) {
    try {
      return supportedLocales.firstWhere(
        (locale) => locale.languageCode == languageCode,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get language name
  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      default:
        return locale.languageCode;
    }
  }

  /// Get language code
  static String getLanguageCode(Locale locale) {
    return locale.languageCode;
  }

  /// Get country code
  static String getCountryCode(Locale locale) {
    return locale.countryCode ?? '';
  }

  /// Get full locale string
  static String getFullLocaleString(Locale locale) {
    return '${locale.languageCode}_${locale.countryCode}';
  }

  /// Check if current locale is Arabic
  static bool isArabic(BuildContext context) {
    return getCurrentLocale(context).languageCode == 'ar';
  }

  /// Check if current locale is English
  static bool isEnglish(BuildContext context) {
    return getCurrentLocale(context).languageCode == 'en';
  }

  // /// Get text direction
  // static TextDirection getTextDirection(BuildContext context) {
  //   return isArabic(context) ? TextDirection.rtl : TextDirection.ltr;
  // }

  /// Get alignment
  static Alignment getAlignment(BuildContext context) {
    return isArabic(context) ? Alignment.centerRight : Alignment.centerLeft;
  }

  /// Get cross alignment
  static CrossAxisAlignment getCrossAxisAlignment(BuildContext context) {
    return isArabic(context) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  }

  /// Get main alignment
  static MainAxisAlignment getMainAxisAlignment(BuildContext context) {
    return isArabic(context) ? MainAxisAlignment.end : MainAxisAlignment.start;
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'language_strings.dart';

class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  
  Map<String, String> get _localizedStrings {
    switch(locale.languageCode) {
      case 'es':
        return spanishStrings;
      case 'fr':
        return frenchStrings;
      case 'hi':
        return hindiStrings;
      case 'ta':
        return tamilStrings;
      case 'te':
        return teluguStrings;
      default:
        return englishStrings;
    }
  }
  
  String translate(String key) {
    return _localizedStrings[key] ?? englishStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr', 'hi', 'ta', 'te'].contains(locale.languageCode);
  }
  
  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }
  
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
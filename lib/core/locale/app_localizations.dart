import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  static dynamic _localizedStrings;

  Future<void> load() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map<String, dynamic>((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  static String translate(String key) =>
      _localizedStrings?[key]?.toString() ?? key;

  /// {
  ///    "msg":"{} are written in the {} language",
  ///    "msg_named":"Easy localization are written in the {lang} language",
  ///    "msg_mixed":"{} are written in the {lang} language",
  ///    "gender":{
  ///       "male":"Hi man ;) {}",
  ///       "female":"Hello girl :) {}",
  ///       "other":"Hello {}"
  ///    }
  /// }
  ///
  ///
  ///  Text('msg_named').tr(namedArgs: {'lang': 'Dart'}),   // namedArgs
  ///
  /// {
  ///    "msg_mixed":"{lang} are written in the language",
  ///    "gender":{
  ///       "male":"Hi man",
  ///    }
  /// }
  ///   ///  Text('gender').tr(namedArgs: {'lang': 'Dart'}),   // namedArgs
/*
  static String _translate(
    String key, {
    Map<String, String>? namedArgs,
    String? keyPath,
  }) {
    late String value;
    if (keyPath == null) {
      value = _localizedStrings?[key]?.toString() ?? key;
    } else {
      Map keyMap = keyPath.split('.').asMap();
      var nestedMap;
      print(keyMap);
      keyMap.forEach((index, key) {
        if (index == 0) {
          value = _localizedStrings[key];
        } else {
          value = nestedMap[key];
        }
      });
    }

    if (namedArgs != null) {
      for (final String key in namedArgs.keys) {
        value = value.replaceAll(key, namedArgs[key]!);
      }
      return value;
    }
    return value;
  }
*/

  bool get isEnLocale => locale.languageCode == 'en';
}

extension Translation on String {
  String tr({String? keyPath}) => AppLocalizations.translate(this);
}

extension TranslationInWidget on Text {
  String tr() => AppLocalizations.translate(data!);
}

extension AppLocalization on BuildContext {
  bool get isEnLocale => AppLocalizations.of(this)!.isEnLocale;
}

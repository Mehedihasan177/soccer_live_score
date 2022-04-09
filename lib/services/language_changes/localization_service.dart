// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'en_us.dart';
import 'fr_fr copy.dart';

class LocalizationService extends Translations {
  static final locale = Locale('en', 'US');
  static final fallbackLocale = Locale('en', 'US');

  // Supported languages
  static final langs = [
    'English',
    'Vietnamese',
  ];

  // Supported locales
  static final locales = [
    Locale('en', 'US'),
    Locale('vi', 'VI'),
  ];

  // Keys and their translations
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'vi_VI': viVI,
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);

    final box = GetStorage();
    box.write('lng', lang);

    Get.updateLocale(locale);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }

  Locale getCurrentLocale() {
    final box = GetStorage();
    Locale defaultLocale;

    if (box.read('lng') != null) {
      final locale =
          LocalizationService().getLocaleFromLanguage(box.read('lng'));

      defaultLocale = locale;
    } else {
      defaultLocale = Locale(
        'en',
        'US',
      );
    }

    return defaultLocale;
  }

  String getCurrentLang() {
    final box = GetStorage();
    return box.read('lng') ?? "English";
  }
}

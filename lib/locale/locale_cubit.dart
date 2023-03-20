import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/locale/app_localization.dart';
import 'package:flutter_application_1/preferences/preferences_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  final PreferencesManager preferenceManager;

  LocaleCubit(this.preferenceManager) : super(const Locale(codeAr)) {
    getDefaultLocale();
  }

  void changeLocale(LocaleApp selectedLanguage) async {
    final defaultLanguageCode = await preferenceManager.getLocale();

    if (selectedLanguage == LocaleApp.ar && defaultLanguageCode != codeAr) {
      await preferenceManager.setLocale(codeAr);
      emit(const Locale(codeAr));
    } else if (selectedLanguage == LocaleApp.en &&
        defaultLanguageCode != codeEn) {
      await preferenceManager.setLocale(codeEn);
      emit(const Locale(codeEn));
    }
  }

  void getDefaultLocale() async {
    final defaultLanguageCode = await preferenceManager.getLocale();
    Locale locale;
    if (defaultLanguageCode == null) {
      locale = Locale(defaultSystemLocale);
    } else {
      locale = Locale(defaultLanguageCode);
    }
    await preferenceManager.setLocale(locale.languageCode);
    emit(locale);
  }

  String get defaultSystemLocale => Platform.localeName.substring(0, 2);
}

enum LocaleApp { en, ar }

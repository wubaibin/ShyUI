import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';

import 'dart:ui' as ui;

import 'en_US.dart';
import 'zh_CN.dart';

class TranslationService extends Translations {
  static Locale get locale =>
      Get.deviceLocale ?? ui.PlatformDispatcher.instance.locale;
  static const fallbackLocale = Locale('en', 'US');
  static const supportedLocales = [
    Locale('zh', 'CN'),
    Locale('en', 'US'),
  ];
  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'zh_CN': zhCN,
      };
}

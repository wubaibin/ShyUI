import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shy_ui/lang/index.dart';
import 'package:shy_ui/router/pages.dart';
import 'package:shy_ui/styles/theme.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: AppTheme.light,
      locale: ui.PlatformDispatcher.instance.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      supportedLocales: TranslationService.supportedLocales,
      translations: TranslationService(),
      localizationsDelegates: TranslationService.localizationsDelegates,
    );
  }
}

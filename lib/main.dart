import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_face/lang/index.dart';
import 'package:flutter_face/router/pages.dart';
import 'package:flutter_face/styles/theme.dart';
import 'package:flutter_face/utils/storage.dart';
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
  Locale? locale;

  @override
  void initState() {
    super.initState();
    _disposeLocale();
  }

  void _disposeLocale() async {
    final res = await Storage().get("lang");
    if (res == null) {
      setState(() {
        locale = ui.PlatformDispatcher.instance.locale;
      });
      return;
    }
    final localeValue =
        res == 'zh_CN' ? const Locale('zh', 'CN') : const Locale('en', 'US');
    setState(() {
      locale = localeValue;
    });
    Get.updateLocale(localeValue);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: AppTheme.light,
      locale: locale ?? ui.PlatformDispatcher.instance.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      supportedLocales: TranslationService.supportedLocales,
      translations: TranslationService(),
      localizationsDelegates: TranslationService.localizationsDelegates,
    );
  }
}

import 'package:flutter_face/pages/button/index.dart';
import 'package:flutter_face/pages/home/index.dart';
import 'package:flutter_face/pages/icon/index.dart';
import 'package:flutter_face/pages/main/index.dart';
import 'package:flutter_face/pages/popup/index.dart';
import 'package:flutter_face/pages/toast/index.dart';
import 'package:flutter_face/pages/user/index.dart';
import 'package:get/get.dart';

part 'routes.dart';

class AppPages {
  static const initialRoute = AppRoutes.mainPage;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.mainPage,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.userPage,
      page: () => const UserPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: AppRoutes.buttonPage,
      page: () => const ButtonPage(),
      binding: ButtonBinding(),
    ),
    GetPage(
      name: AppRoutes.iconPage,
      page: () => const IconPage(),
      binding: IconBinding(),
    ),
    GetPage(
      name: AppRoutes.toastPage,
      page: () => const ToastPage(),
      binding: ToastBinding(),
    ),
    GetPage(
      name: AppRoutes.popupPage,
      page: () => const PopupPage(),
      binding: PopupBinding(),
    ),
  ];
}

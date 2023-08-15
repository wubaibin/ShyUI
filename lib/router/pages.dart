import 'package:flutter_face/pages/home/index.dart';
import 'package:flutter_face/pages/main/index.dart';
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
  ];
}

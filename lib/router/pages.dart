import 'package:shy_ui/pages/Popover/index.dart';
import 'package:shy_ui/pages/app_bar/index.dart';
import 'package:shy_ui/pages/button/index.dart';
import 'package:shy_ui/pages/checkbox/index.dart';
import 'package:shy_ui/pages/circle/index.dart';
import 'package:shy_ui/pages/dashed/index.dart';
import 'package:shy_ui/pages/dialog/index.dart';
import 'package:shy_ui/pages/drop_down_menu/index.dart';
import 'package:shy_ui/pages/empty/index.dart';
import 'package:shy_ui/pages/home/index.dart';
import 'package:shy_ui/pages/icon/index.dart';
import 'package:shy_ui/pages/image_picker/index.dart';
import 'package:shy_ui/pages/input/index.dart';
import 'package:shy_ui/pages/list/index.dart';
import 'package:shy_ui/pages/loading/index.dart';
import 'package:shy_ui/pages/main/index.dart';
import 'package:shy_ui/pages/notice_bar/index.dart';
import 'package:shy_ui/pages/overlay/index.dart';
import 'package:shy_ui/pages/popup/index.dart';
import 'package:shy_ui/pages/radio/index.dart';
import 'package:shy_ui/pages/tab_bar/index.dart';
import 'package:shy_ui/pages/textarea/index.dart';
import 'package:shy_ui/pages/toast/index.dart';
import 'package:shy_ui/pages/transition/index.dart';
import 'package:shy_ui/pages/user/index.dart';
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
      name: AppRoutes.transitionPage,
      page: () => const TransitionPage(),
      binding: TransitionBinding(),
    ),
    GetPage(
      name: AppRoutes.popupPage,
      page: () => const PopupPage(),
      binding: PopupBinding(),
    ),
    GetPage(
      name: AppRoutes.overlayPage,
      page: () => const OverlayPage(),
      binding: OverlayBinding(),
    ),
    GetPage(
      name: AppRoutes.inputPage,
      page: () => const InputPage(),
      binding: InputBinding(),
    ),
    GetPage(
      name: AppRoutes.textareaPage,
      page: () => const TextareaPage(),
      binding: TextareaBinding(),
    ),
    GetPage(
      name: AppRoutes.checkboxPage,
      page: () => const CheckboxPage(),
      binding: CheckboxBinding(),
    ),
    GetPage(
      name: AppRoutes.radioPage,
      page: () => const RadioPage(),
      binding: RadioBinding(),
    ),
    GetPage(
      name: AppRoutes.imagePickerPage,
      page: () => const ImagePickerPage(),
      binding: ImagePickerBinding(),
    ),
    GetPage(
      name: AppRoutes.dialogPage,
      page: () => const DialogPage(),
      binding: DialogBinding(),
    ),
    GetPage(
      name: AppRoutes.dropDownMenuPage,
      page: () => const DropDownMenuPage(),
      binding: DropDownMenuBinding(),
    ),
    GetPage(
      name: AppRoutes.popoverPage,
      page: () => const PopoverPage(),
      binding: PopoverBinding(),
    ),
    GetPage(
      name: AppRoutes.loadingPage,
      page: () => const LoadingPage(),
      binding: LoadingBinding(),
    ),
    GetPage(
      name: AppRoutes.circlePage,
      page: () => const CirclePage(),
      binding: CircleBinding(),
    ),
    GetPage(
      name: AppRoutes.listPage,
      page: () => const ListPage(),
      binding: ListBinding(),
    ),
    GetPage(
      name: AppRoutes.dashedPage,
      page: () => const DashedPage(),
      binding: DashedBinding(),
    ),
    GetPage(
      name: AppRoutes.emptyPage,
      page: () => const EmptyPage(),
      binding: EmptyBinding(),
    ),
    GetPage(
      name: AppRoutes.noticeBarPage,
      page: () => const NoticeBarPage(),
      binding: NoticeBarBinding(),
    ),
    GetPage(
      name: AppRoutes.appBarPage,
      page: () => const AppBarPage(),
      binding: AppBarBinding(),
    ),
    GetPage(
      name: AppRoutes.tabBarPage,
      page: () => const TabBarPage(),
      binding: TabBarBinding(),
    ),
  ];
}

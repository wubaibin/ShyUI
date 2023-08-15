import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'index.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    // 表示主题和颜色的亮暗模式
    brightness: Brightness.light,
    // 页面背景颜色
    scaffoldBackgroundColor: AppColor.bgColor,
    // 水波纹
    splashColor: Colors.transparent,
    // 高亮颜色
    highlightColor: Colors.transparent,
    // 这个颜色一般用在按钮和可点击的文本和图标上
    primaryColor: AppColor.themeColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      //次要角色用于 UI 中不太突出的组件，例如  chips，同时扩大了颜色表达的机会
      secondary: AppColor.themeColor,
    ),
    appBarTheme: const AppBarTheme(
      // appBar 阴影
      elevation: 0,
      // 标题是否居中
      centerTitle: true,
      // appBar 背景颜色
      backgroundColor: AppColor.appBarBgColor,
      // appBar 图标样式
      iconTheme: IconThemeData(
        color: AppColor.appBarTitle,
        size: 24,
      ),
      // appBar 标题样式
      titleTextStyle: TextStyle(
        color: AppColor.appBarTitle,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      // toolbar 样式
      toolbarTextStyle: TextStyle(
        color: AppColor.appBarTitle,
        fontSize: 20,
        // fontWeight: FontWeight.w500,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 设置状态栏颜色
        statusBarIconBrightness: Brightness.dark, // 设置状态栏文字颜色
      ),
    ),
    // tabBar 主题
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColor.themeColor,
      unselectedLabelColor: AppColor.threearyText,
    ),
  );
}

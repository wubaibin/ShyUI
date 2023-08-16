import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      id: "main",
      builder: (_) {
        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: _.state.pages[_.state.index],
          bottomNavigationBar: NavigationWidget(
            onIndexChanged: _.onIndexChanged,
          ),
        );
      },
    );
  }
}

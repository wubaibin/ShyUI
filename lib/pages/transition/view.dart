import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/ui/list.dart';
import 'package:shy_ui/ui/transition/index.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class TransitionPage extends GetView<TransitionController> {
  const TransitionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransitionController>(
      id: "transition",
      builder: (_) {
        return StageWidget(
          title: "Transition 动画",
          children: [
            const DetailTitleWidget(title: '动画', top: 20),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: 'Fade',
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onPress: () {
                _.state.fade = !_.state.fade;
                _.update(["transition"]);
              },
            ),
            TransitionWidget(
              show: _.state.fade,
              name: TransitionType.fade,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: 'SlideLeft',
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onPress: () {
                _.state.slideLeft = !_.state.slideLeft;
                _.update(["transition"]);
              },
            ),
            TransitionWidget(
              show: _.state.slideLeft,
              name: TransitionType.slideLeft,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: 'FadeLeft',
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onPress: () {
                _.state.fadeLeft = !_.state.fadeLeft;
                _.update(["transition"]);
              },
            ),
            TransitionWidget(
              show: _.state.fadeLeft,
              name: TransitionType.fadeLeft,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.white,
              ),
            ),
            const DetailTitleWidget(title: '按下放大松开缩小'),
            const SizedBox(height: 8),
            ScaleTransitionWidget(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.white,
              ),
            )
          ],
        );
      },
    );
  }
}

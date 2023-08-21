import 'package:flutter/material.dart';
import 'package:flutter_face/components/detail_title.dart';
import 'package:flutter_face/components/stage.dart';
import 'package:flutter_face/ui/input.dart';
import 'package:flutter_face/ui/keyboard.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class InputPage extends GetView<InputController> {
  const InputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputController>(
      id: "input",
      builder: (_) {
        return KeyboardWidget(
          child: StageWidget(
            title: "Input 输入框",
            children: [
              const DetailTitleWidget(title: '基础用法', top: 20),
              _buildInputContainer(child: const Input(placeholder: "请输入内容")),
              const DetailTitleWidget(title: '带有清除icon'),
              _buildInputContainer(
                child: const Input(placeholder: "带有清除icon", clear: true),
              ),
              const DetailTitleWidget(title: '可以自动聚焦'),
              _buildInputContainer(
                child: const Input(placeholder: "将会自动聚焦", autofocus: true),
              ),
              const DetailTitleWidget(title: '控制最大输入长度的input'),
              _buildInputContainer(
                child: const Input(placeholder: "最大输入长度为10", maxLength: 10),
              ),
              DetailTitleWidget(title: '实时获取输入值：${_.state.value}'),
              _buildInputContainer(
                child: Input(
                  placeholder: "输入同步到view中",
                  onChanged: (value) {
                    _.state.value = value;
                    _.update(["input"]);
                  },
                ),
              ),
              const DetailTitleWidget(title: '控制键盘的input'),
              _buildInputContainer(
                child: Input(
                  placeholder: "输入123自动收起键盘",
                  onChanged: (value) {
                    if (value == "123") {
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ),
              const DetailTitleWidget(title: '数字输入的input'),
              _buildInputContainer(
                child: const Input(
                  type: TextInputType.number,
                  placeholder: "这是一个数字输入框",
                ),
              ),
              const DetailTitleWidget(title: '密码输入的input'),
              _buildInputContainer(
                child: const Input(password: true, placeholder: "这是一个密码输入框"),
              ),
              const DetailTitleWidget(title: '带小数点的input'),
              _buildInputContainer(
                child: const Input(
                  type: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  placeholder: "带小数点的数字键盘",
                ),
              ),
              const DetailTitleWidget(title: '控制占位符颜色的input'),
              _buildInputContainer(
                child: const Input(
                  placeholder: "占位符字体是红色的",
                  placeholderStyle: TextStyle(
                    fontSize: 15,
                    height: 1.2,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

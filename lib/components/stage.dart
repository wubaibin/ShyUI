import 'package:flutter/material.dart';
import 'package:flutter_face/ui/app_bar.dart';

class StageWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const StageWidget({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}

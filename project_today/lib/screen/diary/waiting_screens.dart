import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/index.dart';

class WaitingScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Diaryhometemplate(
        headerTitle: 'SS507',
        name: "혜령",
        topText: "님이 일기를 쓰고 있어요",
        bottomText: "눌러서 재촉해보세요!",
        imgPath: 'assets/images/img_group.png',
        onPressed: () {});
  }
}

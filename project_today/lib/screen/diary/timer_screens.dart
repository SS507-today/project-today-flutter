import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/index.dart';

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Diaryhometemplate(
        headerTitle: 'SS507',
        topText: "친구들이 모두 들어오면\n교환일기가 시작돼요!",
        createdAt: DateTime.now().add(Duration(minutes: 2)),
        imgPath: 'assets/images/img_group.png',
        isActive: false,
        onPressed: () {});
  }
}

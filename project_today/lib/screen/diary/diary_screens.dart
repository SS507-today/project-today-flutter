import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/index.dart';

class DiaryScreen extends StatelessWidget {
  final List<Map<String, String?>> rules = [
    {'title': '규칙 1', 'content': '까먹지 않고 꼭 쓰기'},
    {'title': '규칙 2', 'content': '남의 험담은 하지 않기'},
    {'title': '규칙 3', 'content': '성의있게 쓰기~!'},
  ];

  @override
  Widget build(BuildContext context) {
    return Diaryhometemplate(
      headerTitle: 'SS507',
      topText: "새로운 일기를 담은\n교환일기가 도착했어요!",
      showGlowGradientBox: true,
      onTapGradientBox: () {
        Navigator.pushNamed(context, '/read');
      },
      rules: rules,
      onPressed: () {
        Navigator.pushNamed(context, '/past');
      },
    );
  }
}

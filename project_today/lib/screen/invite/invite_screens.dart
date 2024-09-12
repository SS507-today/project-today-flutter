import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/index.dart';

class InviteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Diaryhometemplate(
        headerTitle: 'SS507',
        name: "떵이",
        topText: "님외 5명이",
        bottomText: "오늘을 교환하고 싶어해요",
        showGradientBox: true,
        rules: [
          {'content': '안녕하세요 저희는 정보관에 갇혀사는 SS507입니다 푸하핫 공주들아 들어와라~'},
        ],
        buttonText: '초대 수락하기',
        onPressed: () {});
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/onboardTemplate.dart';

class OnboardScreen extends StatefulWidget {
  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  String nickname = '';
  bool isButtonActive = false;

  void _onNicknameChanged(String value) {
    setState(() {
      nickname = value;
      isButtonActive = value.isNotEmpty;
    });
  }

  void _onNextPressed() {
    Navigator.pushReplacementNamed(context, '/group');
  }

  @override
  Widget build(BuildContext context) {
    return OnboardTemplate(
      nickname: nickname,
      isButtonActive: isButtonActive,
      onNicknameChanged: _onNicknameChanged,
      onNextPressed: _onNextPressed,
      titleText: "오늘은에서 사용할\n닉네임을 입력해 주세요",
      hintText: "2 ~ 8자 이내로 입력해 주세요",
    );
  }
}

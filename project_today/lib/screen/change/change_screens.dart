import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/organisms/index.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/atoms.dart';

class ChangeScreen extends StatefulWidget {
  @override
  _ChangeScreenState createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  bool isButtonActive = false;

  void _onNicknameChanged(String value) {
    setState(() {
      isButtonActive = value.length >= 2 && value.length <= 8;
    });
  }

  void _onNextPressed() {
    if (isButtonActive) {
      Navigator.pushNamed(context, '/setting');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              backgroundColor: Colors.transparent,
              title: "닉네임 변경",
              showBackButton: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 29, left: 20, right: 20),
              child: CustomTextField(
                hintText: "2 ~ 8자 이내로 입력해 주세요",
                onChanged: _onNicknameChanged,
              ),
            ),
            const Spacer(),
            DefaultActionButton(
              text: "완료",
              isActive: isButtonActive,
              onPressed: _onNextPressed,
            ),
          ],
        ),
      ),
    );
  }
}

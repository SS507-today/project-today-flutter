import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/atoms.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 2,
                colors: [
                  Color(0xFFFFECDA).withOpacity(0.7),
                  Color(0xFFFFD8E1).withOpacity(0.7),
                  Colors.white.withOpacity(1),
                ],
                stops: [0.0, 0.8, 1.0],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 130),
                const Text(
                  "오늘은에서 사용할\n닉네임을 입력해 주세요",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: GreyColorSystem.Grey80,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                CustomTextField(
                  hintText: "2 ~ 8자 이내로 입력해 주세요",
                  onChanged: _onNicknameChanged,
                ),
              ],
            ),
          ),
          const Spacer(),
          DefaultActionButton(
            text: "다음",
            isActive: isButtonActive,
            onPressed: _onNextPressed,
          ),
        ],
      ),
    );
  }
}

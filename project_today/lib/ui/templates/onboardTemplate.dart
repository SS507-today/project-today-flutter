import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/atoms.dart';

class OnboardTemplate extends StatelessWidget {
  final String nickname;
  final bool isButtonActive;
  final ValueChanged<String> onNicknameChanged;
  final VoidCallback onNextPressed;
  final String titleText;
  final String hintText;

  const OnboardTemplate({
    required this.nickname,
    required this.isButtonActive,
    required this.onNicknameChanged,
    required this.onNextPressed,
    required this.titleText,
    required this.hintText,
  });

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
                Text(
                  titleText,
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
                  hintText: hintText,
                  onChanged: onNicknameChanged,
                ),
              ],
            ),
          ),
          const Spacer(),
          DefaultActionButton(
            text: "다음",
            isActive: isButtonActive,
            onPressed: onNextPressed,
          ),
        ],
      ),
    );
  }
}

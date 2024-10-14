import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/kakaoLoginButton.dart';

class Introtemplate extends StatelessWidget {
  final bool showLoginButton; // KakaoLoginButton 활성화 여부
  final VoidCallback? onPressed; // KakaoLoginButton의 콜백 함수

  Introtemplate({required this.showLoginButton, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: GredientColorSystem.BgGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 185,
                    height: 185,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "교환일기로 공유하는 오늘의 일기",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: GreyColorSystem.Grey80,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            if (showLoginButton) // 로그인 버튼이 필요할 때만 표시
              KakaoLoginButton(
                onPressed: onPressed!,
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/data/services/index.dart';
import 'package:project_today/ui/atoms/kakaoLoginButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService(); // AuthService 인스턴스 생성

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
            // 카카오 로그인 버튼
            KakaoLoginButton(
              onPressed: () async {
                await _authService.loginWithKakao(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

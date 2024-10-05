import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/data/services/index.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService(); // AuthService 인스턴스 생성

  @override
  void initState() {
    super.initState();
    // 3초 후에 checkUserStatus 호출
    Future.delayed(Duration(seconds: 3), () {
      _authService.checkUserStatus(context);
    });
  }

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
          ],
        ),
      ),
    );
  }
}

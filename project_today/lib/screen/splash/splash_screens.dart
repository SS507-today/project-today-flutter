import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart'; // 카카오 SDK 임포트
import 'package:project_today/ui/atoms/kakaoLoginButton.dart';
import 'package:project_today/core/constant/colors.dart';

enum SocialPlatform {
  kakao,
  none, //로그아웃 용도
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveScreen() {
    Navigator.pushReplacementNamed(context, '/onboard');
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 3000), () {
      moveScreen();
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
            KakaoLoginButton(
              onPressed: () async {
                print('>>>>> 임시 로그인');
                // try {
                //   OAuthToken token;
                //   if (await isKakaoTalkInstalled()) {
                //     try {
                //       token = await UserApi.instance.loginWithKakaoTalk();
                //       print('>>>>>카카오톡으로 로그인 성공: ${token.accessToken}');
                //     } catch (error) {
                //       print('>>>>>카카오톡으로 로그인 실패: $error');
                //       token = await UserApi.instance.loginWithKakaoAccount();
                //       print('>>>>>카카오계정으로 로그인 성공1: ${token.accessToken}');
                //     }
                //   } else {
                //     token = await UserApi.instance.loginWithKakaoAccount();
                //     print('>>>>>카카오계정으로 로그인 성공2: ${token.accessToken}');
                //   }

                //   if (token != null) {
                //     Navigator.pushReplacementNamed(context, '/onboard');
                //   }
                // } catch (error) {
                //   print('>>>>>로그인 중 오류 발생: $error');
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}

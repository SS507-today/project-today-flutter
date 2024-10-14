import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/screen/login/view_model/login_view_model.dart';
import 'package:project_today/ui/atoms/kakaoLoginButton.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = Get.put(LoginViewModel());

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
                await _loginViewModel.login(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

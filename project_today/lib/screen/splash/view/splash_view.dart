import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/screen/splash/view_model/splash_view_model.dart';
import 'package:project_today/ui/templates/index.dart';
import 'package:project_today/ui/atoms/index.dart';

class SplashView extends StatelessWidget {
  final SplashViewModel _splashViewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    _splashViewModel.checkUserStatusAfterDelay(context);
    CustomToastManager().init(context);

    return Introtemplate(
      showLoginButton: false,
    );
  }
}

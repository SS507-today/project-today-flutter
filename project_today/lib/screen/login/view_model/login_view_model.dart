import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/services/auth_service.dart';
import 'package:project_today/ui/atoms/customToast.dart';

class LoginViewModel extends GetxController {
  final AuthService _authService = AuthService();
  final AuthRepository _authRepository = AuthRepository();

  var isLoading = false.obs;

  /// 카카오 로그인 처리
  Future<void> login(BuildContext context) async {
    isLoading.value = true;

    final token = await _authService.loginWithKakao();
    if (token == null) {
      isLoading.value = false;
      print('카카오 로그인 실패');
      return;
    }

    final jwtAccessToken =
        await _authRepository.sendTokenToServer(token.accessToken);
    if (jwtAccessToken != null) {
      final user = await _authService.getKakaoUserInfo();
      if (user != null) {
        await _authRepository.saveTokens(jwtAccessToken, token.accessToken,
            token.refreshToken!, user.id.toString());

        final isRegistered =
            await _authService.checkSignUpStatus(user.id.toString());
        if (isRegistered) {
          CustomToastManager().showCustomToast(
            message: "로그인 성공",
            type: ToastType.POSITIVE,
          );
          isLoading.value = false;

          Navigator.pushReplacementNamed(context, '/onboard');
          return;
        } else {
          CustomToastManager().showCustomToast(
            message: "회원가입 성공",
            type: ToastType.POSITIVE,
          );
          isLoading.value = false;

          Navigator.pushReplacementNamed(context, '/onboard');
          return;
        }
      }
    } else {
      print('서버에서 JWT 토큰을 받지 못했습니다.');
    }

    isLoading.value = false;
  }
}

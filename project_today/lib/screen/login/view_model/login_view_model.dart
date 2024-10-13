import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/services/auth_service.dart';

class LoginViewModel extends GetxController {
  final AuthService _authService = AuthService();
  final AuthRepository _authRepository = AuthRepository();

  var isLoading = false.obs;

  /// 카카오 로그인 처리
  Future<void> login(BuildContext context) async {
    isLoading.value = true;

    // 1. 카카오 로그인
    final token = await _authService.loginWithKakao();
    if (token == null) {
      isLoading.value = false;
      print('카카오 로그인 실패');
      return;
    }

    // 2. 서버로 토큰 전송
    final jwtAccessToken =
        await _authRepository.sendTokenToServer(token.accessToken);
    if (jwtAccessToken != null) {
      // 3. 사용자 정보 저장
      final user = await _authService.getKakaoUserInfo();
      if (user != null) {
        await _authRepository.saveTokens(jwtAccessToken, token.accessToken,
            token.refreshToken!, user.id.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('회원가입 성공!'),
          backgroundColor: Colors.green,
        ));
        Navigator.pushReplacementNamed(context, '/onboard');
      }
    } else {
      print('서버에서 JWT 토큰을 받지 못했습니다.');
    }

    isLoading.value = false;
  }
}

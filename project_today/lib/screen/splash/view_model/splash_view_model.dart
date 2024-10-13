import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/services/auth_service.dart';

class SplashViewModel extends GetxController {
  final AuthService _authService = AuthService();
  final AuthRepository _authRepository = AuthRepository();

  /// 3초 후 사용자 상태 확인
  void checkUserStatusAfterDelay(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () async {
      // 사용자 상태 확인
      await checkUserStatus(context);
    });
  }

  /// 사용자 상태 확인 및 화면 전환 로직 처리
  Future<void> checkUserStatus(BuildContext context) async {
    final tokens = await _authRepository.loadTokens();
    final jwtAccessToken = tokens['jwtAccessToken'];
    final refreshToken = tokens['refreshToken'];
    final authId = tokens['authId'];

    if (jwtAccessToken == null || authId == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    bool isSignedUp = await _authRepository.checkSignUpStatus(authId);
    if (isSignedUp) {
      await handleTokenRefresh(context, refreshToken, authId);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  /// 리프레시 토큰으로 액세스 토큰 갱신 및 화면 전환
  Future<void> handleTokenRefresh(
      BuildContext context, String? refreshToken, String authId) async {
    if (refreshToken == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    // 1. 새로운 카카오 액세스 토큰을 받음
    final newKakaoAccessToken =
        await _authService.refreshKakaoAccessToken(refreshToken);

    if (newKakaoAccessToken != null) {
      // 2. 새로운 카카오 액세스 토큰을 서버에 보내고, JWT 토큰을 받아옴
      final newJwtAccessToken =
          await _authRepository.sendTokenToServer(newKakaoAccessToken);

      if (newJwtAccessToken != null) {
        // 3. JWT 토큰과 카카오 액세스 토큰, 그리고 실제 authId를 저장
        await _authRepository.saveTokens(
          newJwtAccessToken, // JWT 토큰
          newKakaoAccessToken, // 카카오 액세스 토큰
          refreshToken, // 리프레시 토큰
          authId, // 실제 authId
        );
        Navigator.pushReplacementNamed(context, '/group');
      } else {
        Navigator.pushReplacementNamed(context, '/login'); // JWT 토큰을 받지 못했을 때
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login'); // 카카오 액세스 토큰 갱신 실패 시
    }
  }
}

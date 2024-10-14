import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:project_today/data/repositories/nickname_repository.dart';
import 'package:project_today/data/repositories/auth_repository.dart';

class OnboardViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final NickNameRepository _nickNameRepository = NickNameRepository();

  var nickname = ''.obs;
  var isButtonActive = false.obs;

  void onNicknameChanged(String value) {
    nickname.value = value;
    isButtonActive.value = value.isNotEmpty;
  }

  Future<void> onNextPressed(BuildContext context) async {
    if (nickname.value.length < 2 || nickname.value.length > 8) {
      showSnackbar("닉네임 오류", "닉네임은 2자에서 8자 이내로 설정해야 합니다.");
      return;
    }

    try {
      final tokens = await _authRepository.loadTokens();
      final String? accessToken = tokens['jwtAccessToken'];

      if (accessToken == null) {
        showSnackbar("토큰 오류", "토큰을 불러오는 데 실패했습니다.");
        return;
      }

      // 레포지토리를 통해 닉네임 설정 처리
      final success =
          await _nickNameRepository.setNickName(nickname.value, accessToken);

      if (success) {
        Navigator.pushReplacementNamed(context, '/group');
      } else {
        showSnackbar("닉네임 설정 실패", "닉네임 설정에 실패했습니다. 다시 시도해 주세요.");
      }
    } catch (e) {
      showSnackbar("오류 발생", "오류가 발생했습니다");
    }
  }

  /// Snackbar를 통해 메시지 표시
  // TODO 커스텀 토스트메세지로 변경
  void showSnackbar(String title, String message) {
    Get.snackbar(
      title, // Snackbar 제목
      message, // Snackbar 메시지
      snackPosition: SnackPosition.BOTTOM, // 하단에 표시
      backgroundColor: Get.theme.snackBarTheme.backgroundColor, // 테마 적용
      colorText: Get.theme.snackBarTheme.actionTextColor, // 텍스트 색상
    );
  }
}

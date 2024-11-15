import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_today/data/repositories/nickname_repository.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/ui/atoms/index.dart';

class ChangeViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final NickNameRepository _nicknameRepository = NickNameRepository();

  var nickname = ''.obs; // 닉네임 상태 변수
  var isButtonActive = false.obs; // 버튼 활성화 여부 상태 변수

  /// 닉네임 변경 시 호출
  void onNicknameChanged(String value) {
    nickname.value = value;
    isButtonActive.value = value.length >= 2 && value.length <= 8;
  }

  /// 닉네임 설정 API 호출 및 처리
  Future<void> onNextPressed(BuildContext context) async {
    if (isButtonActive.value) {
      try {
        // 닉네임 설정 API 호출
        final tokens = await _authRepository.loadTokens();
        final String? accessToken = tokens['jwtAccessToken'];

        final success =
            await _nicknameRepository.setNickName(nickname.value, accessToken!);

        if (success) {
          CustomToastManager().showCustomToast(
            message: "닉네임 변경 성공",
            type: ToastType.POSITIVE,
          );
          Navigator.pop(context);
        } else {
          CustomToastManager().showCustomToast(
            message: "닉네임 설정에 실패했습니다. 다시 시도해 주세요.",
            type: ToastType.POSITIVE,
          );
        }
      } catch (e) {
        CustomToastManager().showCustomToast(
          message: "$e",
          type: ToastType.POSITIVE,
        );
      }
    }
  }
}

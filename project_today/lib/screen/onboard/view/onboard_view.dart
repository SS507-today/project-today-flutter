import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/screen/onboard/view_model/onboard_view_model.dart';
import 'package:project_today/ui/templates/onboardTemplate.dart';

class OnboardView extends StatelessWidget {
  final OnboardViewModel _onboardViewModel =
      Get.put(OnboardViewModel()); // ViewModel 인스턴스 생성

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => OnboardTemplate(
        nickname: _onboardViewModel.nickname.value, // 닉네임 값 바인딩
        isButtonActive: _onboardViewModel.isButtonActive.value, // 버튼 활성화 상태 바인딩
        onNicknameChanged: _onboardViewModel.onNicknameChanged, // 닉네임 변경 콜백
        onNextPressed: () async {
          // 비동기 함수 호출
          await _onboardViewModel.onNextPressed(context);
        },
        titleText: "오늘은에서 사용할\n닉네임을 입력해 주세요",
        hintText: "2 ~ 8자 이내로 입력해 주세요",
      ),
    );
  }
}

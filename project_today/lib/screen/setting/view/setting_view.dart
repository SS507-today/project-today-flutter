import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/screen/setting/view_model/setting_view_model.dart';
import 'package:project_today/ui/templates/settingTemplate.dart';
import 'package:skeletonizer/skeletonizer.dart'; // 스켈레톤 로딩 추가

class SettingView extends StatelessWidget {
  final SettingViewModel _viewModel = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final user = _viewModel.user.value;
        final isLoading = _viewModel.isLoading.value;

        return Skeletonizer(
          enabled: isLoading, // 로딩 중일 때 Skeletonizer 활성화
          child: SettingTemplate(
            image: user.image,
            nickname: user.nickname,
            onChangeNickname: () async {
              // 닉네임 변경 화면으로 이동
              await Navigator.pushNamed(context, '/change');
              // 닉네임이 변경된 후 사용자 정보 갱신
              _viewModel.fetchUserInfo();
            },
            isGroupSetting: false,
            onLogout: _onLogout,
          ),
        );
      }),
    );
  }

  // 로그아웃 처리
  void _onLogout() {
    Get.dialog(
      AlertDialog(
        title: Text("로그아웃 되었습니다"),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed('/'); // GetX 네비게이션 사용
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }
}

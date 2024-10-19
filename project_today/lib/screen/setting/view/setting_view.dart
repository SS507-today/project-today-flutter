import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/screen/setting/view_model/setting_view_model.dart';
import 'package:project_today/ui/templates/settingTemplate.dart';

class SettingView extends StatelessWidget {
  final SettingViewModel _userController = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final user = _userController.user.value;

        return SettingTemplate(
          image: user.image,
          nickname: user.nickname,
          onChangeNickname: () async {
            // 닉네임 변경 화면으로 이동
            await Navigator.pushNamed(context, '/change');
            // 닉네임이 변경된 후 사용자 정보 갱신
            _userController.fetchUserInfo();
          },
          isGroupSetting: false,
          onLogout: _onLogout,
        );
      }),
    );
  }

//TODO 진짜 로그인 함수
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

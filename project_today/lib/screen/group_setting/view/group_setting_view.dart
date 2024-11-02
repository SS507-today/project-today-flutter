import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/screen/group_setting/view_model/group_setting_view_model.dart';
import 'package:project_today/ui/molecules/customDialog.dart';
import 'package:project_today/ui/templates/settingTemplate.dart';

class GroupSettingView extends StatelessWidget {
  final GroupSettingViewModel _groupSettingViewModel =
      Get.put(GroupSettingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final groupProfile = _groupSettingViewModel.groupProfile.value;
        return SettingTemplate(
          image: groupProfile.image,
          nickname: groupProfile.profileNickName,
          desc: groupProfile.role,
          deleteTitle: groupProfile.role == 'CREATOR' ? '그룹 삭제' : '그룹 탈퇴',
          onChangeNickname: () async {
            // TODO: 추후 그룹 내 닉네임 설정 API 생길 시
            // 1) 닉네임 변경 화면으로 이동
            //   await Navigator.pushNamed(context, '/change');
            // 2) 닉네임이 변경된 후 사용자 정보 갱신
            // _groupSettingViewModel.fetchGroupProfile();
          },
          onThirdOption: () {
            if (groupProfile.role == 'CREATOR') {
              showCustomDialog(
                context,
                "그룹을 삭제하시겠습니까?",
                "취소",
                "삭제",
                () {
                  _groupSettingViewModel.deleteGroup(context);
                },
              );
            } else {
              showCustomDialog(
                context,
                "그룹에서 탈퇴하시겠습니까?",
                "취소",
                "탈퇴",
                () {
                  _groupSettingViewModel.leaveGroup(context);
                },
              );
            }
          },
        );
      }),
    );
  }
}

import 'dart:ffi';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/repositories/group_profile_repository.dart';
import 'package:project_today/data/models/index.dart';
import 'package:project_today/data/repositories/current_group_id_repository.dart'
    as globals;
import 'package:project_today/data/services/delete_share_group.dart';
import 'package:project_today/screen/group/view/group_view.dart';
import 'package:project_today/ui/atoms/index.dart';

class GroupSettingViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final GroupProfileRepository _groupProfileRepository =
      GroupProfileRepository();
  final DeleteShareGroup _deleteShareGroup = DeleteShareGroup();

  /// 그룹 프로필 정보를 관리하는 상태 변수
  var groupProfile = GroupProfile(
    shareGroupId: 0,
    profileId: 0,
    profileNickName: '',
    description: '',
    image: '',
    role: '',
    joinedAt: '',
    myTurn: false,
  ).obs;

  /// 프로필 정보를 불러오는 동안 로딩 상태 관리
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('GroupSettingViewModel onInit called');

    // currentGroupId가 변경될 때마다 fetchGroupProfile 호출
    ever(globals.currentGroupId, (_) {
      fetchGroupProfile();
    });

    // 최초 초기화 시에도 fetchGroupProfile 호출
    fetchGroupProfile();
  }

  @override
  void onReady() {
    super.onReady();
    print('GroupSettingViewModel onReady called');
  }

  /// 그룹 프로필 정보를 API에서 가져와서 상태 업데이트
  Future<void> fetchGroupProfile() async {
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];
    if (accessToken != null) {
      try {
        isLoading.value = true;
        print(
            'Fetching profile for shareGroupId: ${globals.currentGroupId.value} with accessToken: $accessToken');

        // 프로필 정보 가져오기
        final fetchedProfile = await _groupProfileRepository.getMyProfileInfo(
            globals.currentGroupId.value, accessToken);

        if (fetchedProfile != null) {
          print('Fetched profile: ${fetchedProfile.toJson()}'); // 응답 로그 추가
          groupProfile.value = fetchedProfile;
        } else {
          print("프로필 데이터를 불러오지 못했습니다.");
        }
      } catch (e) {
        print("프로필 정보를 가져오는 중 오류 발생: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }

  /// 닉네임 업데이트
  void updateNickname(String newNickname) {
    groupProfile.update((profile) {
      if (profile != null) {
        profile.profileNickName = newNickname;
      }
    });
  }

  /// 설명 업데이트
  void updateDescription(String newDescription) {
    groupProfile.update((profile) {
      if (profile != null) {
        profile.description = newDescription;
      }
    });
  }

  /// 그룹 탈퇴

  Future<void> leaveGroup(BuildContext context) async {
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];
    // 그룹 탈퇴 API 호출
    final result = await _deleteShareGroup.leaveShareGroup(
        globals.currentGroupId.value, accessToken!);
    // API 호출 결과 처리
    if (result != null) {
      print("그룹 탈퇴 성공: ${result['shareGroupId']}번 그룹에서 탈퇴했습니다.");

      CustomToastManager().showCustomToast(
        message: "그룹에서 탈퇴했습니다.",
        type: ToastType.POSITIVE,
      );
      // 쌓여 있는 모든 라우트를 제거하고 로그인 화면으로 이동
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => GroupView()), // LoginView를 직접 지정
        (Route<dynamic> route) => false,
      );
    } else {
      CustomToastManager().showCustomToast(
        message: "그룹 탈퇴 실패",
        type: ToastType.NEGATIVE,
      );
      print("그룹 탈퇴 실패");
    }
  }

  /// 그룹 프로필 정보 초기화 (로그아웃 또는 그룹 변경 시 사용)
  void resetProfile() {
    groupProfile.value = GroupProfile(
      shareGroupId: 0,
      profileId: 0,
      profileNickName: '',
      description: '',
      image: '',
      role: '',
      joinedAt: '',
      myTurn: false,
    );
  }
}

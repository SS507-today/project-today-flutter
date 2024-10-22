import 'package:get/get.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/repositories/group_profile_repository.dart';
import 'package:project_today/data/models/index.dart';
import 'package:project_today/data/repositories/current_group_id_repository.dart'
    as globals;

class GroupSettingViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final GroupProfileRepository _groupProfileRepository =
      GroupProfileRepository();

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

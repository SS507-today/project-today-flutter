import 'package:get/get.dart';
import 'package:project_today/data/repositories/member_repository.dart';
import 'package:project_today/data/models/index.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/repositories/current_group_id_repository.dart'
    as globals;

class MemberViewModel extends GetxController {
  final MemberRepository _memberRepository = MemberRepository();
  final AuthRepository _authRepository = AuthRepository();

  var profilesList = <GroupProfile>[].obs; // 프로필 리스트를 관리하는 상태 변수
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 그룹 ID가 변경될 때마다 프로필 리스트를 새로 불러옴
    ever(globals.currentGroupId, (_) {
      fetchProfilesList();
    });
    // 처음 초기화할 때도 리스트를 가져옴
    fetchProfilesList();
  }

  /// 프로필 리스트를 가져오는 함수
  Future<void> fetchProfilesList() async {
    isLoading.value = true;

    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken != null) {
      try {
        final shareGroupId = globals.currentGroupId.value; // RxInt로 접근
        final profiles = await _memberRepository.fetchProfilesList(
            shareGroupId, accessToken);

        if (profiles != null) {
          profilesList.value = profiles;
        } else {
          print('프로필 리스트를 불러오는 데 실패했습니다.');
        }
      } catch (e) {
        print('프로필 리스트를 가져오는 중 오류 발생: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }
}

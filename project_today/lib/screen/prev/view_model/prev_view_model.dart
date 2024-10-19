import 'package:get/get.dart';
import 'package:project_today/data/repositories/detail_group_repository.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/repositories/current_group_id_repository.dart'
    as globals;

class PrevViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final DetailGroupRepository _detailGroupRepository = DetailGroupRepository();

  var groupName = ''.obs;
  var groupDescription = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // currentGroupId가 변경될 때마다 fetchDetailGroup 호출
    ever(globals.currentGroupId, (_) {
      fetchDetailGroup(globals.currentGroupId.value);
    });

    // 초기 그룹 데이터를 불러옴
    fetchDetailGroup(globals.currentGroupId.value);
  }

  /// 그룹 상세 정보 가져오는 함수
  Future<void> fetchDetailGroup(int groupId) async {
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];
    if (accessToken != null) {
      try {
        final detailGroup =
            await _detailGroupRepository.fetchDetailGroup(groupId, accessToken);
        if (detailGroup != null) {
          groupName.value = detailGroup.groupName;
          groupDescription.value = detailGroup.description;
        }
      } catch (e) {
        print('그룹 정보를 가져오는 중 오류 발생: $e');
      }
    }
  }
}

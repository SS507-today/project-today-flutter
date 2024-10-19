import 'package:project_today/data/models/index.dart';
import 'package:project_today/data/services/index.dart';

class GroupProfileRepository {
  final GetMyGroupProfilesService _service = GetMyGroupProfilesService();

  /// 특정 공유 그룹에 속한 내 프로필 정보를 가져와 GroupProfile 모델로 변환하여 반환하는 함수
  Future<GroupProfile?> getMyProfileInfo(
      int shareGroupId, String accessToken) async {
    try {
      // API를 호출하여 데이터를 가져옴
      final data = await _service.getProfilesMyInfo(shareGroupId, accessToken);

      // 데이터가 있으면 GroupProfile로 변환하여 반환
      if (data != null) {
        return GroupProfile.fromJson(data);
      } else {
        print('프로필 데이터를 불러오지 못했습니다.');
        return null;
      }
    } catch (e) {
      print('GroupProfileRepository에서 오류 발생: $e');
      return null;
    }
  }
}

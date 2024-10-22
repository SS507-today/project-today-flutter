import 'package:project_today/data/models/index.dart';
import 'package:project_today/data/services/profiles_list_service.dart';

class MemberRepository {
  final ProfilesListService _profilesListService = ProfilesListService();

  /// 공유 그룹의 프로필 리스트를 가져오는 함수
  Future<List<GroupProfile>?> fetchProfilesList(
      int shareGroupId, String accessToken) async {
    try {
      final response = await _profilesListService.getProfilesListInfo(
          shareGroupId, accessToken);

      if (response != null && response is List) {
        // response가 리스트인 경우
        return response.map((json) => GroupProfile.fromJson(json)).toList();
      } else {
        print('프로필 데이터를 불러오지 못했습니다.');
        return null;
      }
    } catch (e) {
      print('프로필 리스트를 가져오는 중 오류 발생: $e');
      return null;
    }
  }
}

import 'package:project_today/data/models/index.dart';
import 'package:project_today/data/services/get_home_service.dart';

class DetailGroupRepository {
  final GetHomeService _getHomeService = GetHomeService();

  /// 단일 그룹 상세 정보를 가져오는 함수
  Future<SingleGroupModel?> fetchDetailGroup(
      int groupId, String accessToken) async {
    try {
      // API를 통해 그룹 상세 정보 가져오기
      final detailGroup =
          await _getHomeService.fetchGroup(groupId, accessToken);

      // 데이터가 있으면 바로 반환
      if (detailGroup != null) {
        return detailGroup;
      } else {
        print('그룹 데이터를 불러오지 못했습니다.');
        return null;
      }
    } catch (e) {
      print('DetailGroupRepository에서 오류 발생: $e');
      return null;
    }
  }
}

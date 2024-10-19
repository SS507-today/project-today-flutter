import 'dart:convert';
import 'package:project_today/data/services/api_service.dart';

class GetMyGroupProfilesService {
  final ApiService _apiService = ApiService();

  /// 특정 공유그룹에 속한 내 프로필을 조회하는 API 호출 함수
  /// @param [int] shareGroupId - 조회할 공유그룹의 ID
  /// @param [String] accessToken - 사용자 인증을 위한 액세스 토큰
  ///
  /// @return [Map<String, dynamic>?] 서버에서 반환된 정보 (성공 시)
  Future<Map<String, dynamic>?> getProfilesMyInfo(
      int shareGroupId, String accessToken) async {
    try {
      print('Calling API to get profile info for groupId: $shareGroupId');

      // 멤버 정보 조회를 위한 API 호출
      final response = await _apiService.get(
        '/profiles/my',
        queryParams: {'shareGroupId': shareGroupId.toString()},
        accessToken: accessToken,
        excludeContentType: true,
      );

      // 응답 파싱
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print('API response: $responseData'); // 응답 로그 추가

      return responseData['data'];
    } catch (e) {
      print('API 호출 실패: $e');
      return null;
    }
  }
}

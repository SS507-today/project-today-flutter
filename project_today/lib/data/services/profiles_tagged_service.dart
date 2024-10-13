import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_today/data/services/api_service.dart';

class ProfilesTaggedService {
  final ApiService _apiService = ApiService();

  /// 특정 다이어리에 태그된 프로필 리스트를 조회하는 API 호출 함수
  /// @param [String] diaryId  - 조회할 다이어리의 ID
  /// @param [String] accessToken - 사용자 인증을 위한 액세스 토큰
  ///
  /// @return [Map<String, dynamic>?] 서버에서 반환된 정보 (성공 시)
  Future<Map<String, dynamic>?> getProfilesTaggedInfo(
      String diaryId, String accessToken) async {
    try {
      // 멤버 정보 조회를 위한 API 호출
      final response = await _apiService.get(
        '/profiles/diaries/$diaryId/tagged',
        accessToken: accessToken,
        excludeContentType: true,
      );

      // 응답 파싱
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print('특정 다이어리에 태그된 프로필 리스트 조회 성공: ${responseData['data']}');
      return responseData['data'];
    } catch (e) {
      print('특정 다이어리에 태그된 프로필 리스트 조회 실패: $e');
      return null;
    }
  }
}
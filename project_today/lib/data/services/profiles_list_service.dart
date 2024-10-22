import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_today/data/services/api_service.dart';

class ProfilesListService {
  final ApiService _apiService = ApiService();

  /// 특정 공유그룹의 프로필 리스트를 조회하는 API 호출 함수
  Future<List<dynamic>?> getProfilesListInfo(
      int shareGroupId, String accessToken) async {
    try {
      // 멤버 정보 조회를 위한 API 호출
      final response = await _apiService.get(
        '/profiles/profileListInfo',
        queryParams: {'shareGroupId': shareGroupId.toString()},
        accessToken: accessToken,
        excludeContentType: true,
      );

      // 응답 파싱
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print('특정 공유그룹의 프로필 리스트 조회 성공: ${responseData['data']}');

      // 'data' 필드가 리스트일 경우 리스트 형태로 반환
      return responseData['data'];
    } catch (e) {
      print('특정 공유그룹의 프로필 리스트 조회 실패: $e');
      return null;
    }
  }
}

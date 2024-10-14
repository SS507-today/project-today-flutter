import 'dart:convert';
import 'package:project_today/data/services/api_service.dart';

/// 사용자 정보를 조회하는 API 호출을 담당하는 클래스
class MemberMyService {
  final ApiService _apiService = ApiService();

  /// 사용자 정보 조회 API 호출
  Future<Map<String, dynamic>?> fetchMemberMyInfo(String accessToken) async {
    try {
      final response = await _apiService.get(
        '/members/my',
        accessToken: accessToken,
        excludeContentType: true,
      );

      // UTF-8 인코딩 후 파싱
      final responseData = json.decode(utf8.decode(response.bodyBytes));

      return responseData['data'] as Map<String, dynamic>?;
    } catch (e) {
      print('사용자 정보 조회 실패: $e');
      return null;
    }
  }
}

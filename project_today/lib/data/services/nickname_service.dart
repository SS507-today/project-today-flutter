import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_today/data/services/api_service.dart';

class NickNameService {
  final ApiService _apiService = ApiService();

  /// 닉네임 설정 API 호출 함수
  /// @param [String] newNickName - 설정할 새로운 닉네임
  /// @param [String] accessToken - 사용자 인증을 위한 액세스 토큰
  ///
  /// @return [Map<String, dynamic>?] 서버에서 반환된 정보 (성공 시)
  Future<Map<String, dynamic>?> setNickName(
      String newNickName, String accessToken) async {
    try {
      // 닉네임 설정을 위한 API 호출 (Content-Type 제거)
      final response = await _apiService.post(
        '/members/my/nickName',
        queryParams: {'nickName': newNickName}, // Request Parameter로 닉네임 전달
        accessToken: accessToken,
        excludeContentType: true, // Content-Type 제거
      );

      // 응답 파싱
      final responseData = json.decode(response.body);
      print('닉네임 설정 성공: ${responseData['data']}');
      return responseData['data'];
    } catch (e) {
      print('닉네임 설정 실패: $e');
      return null;
    }
  }
}

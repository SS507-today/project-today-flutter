import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:project_today/data/services/api_service.dart';

class BundlesPresignedService {
  final ApiService _apiService = ApiService();

  /// PresignedURL 요청 API 호출 함수
  /// @param [String] shareGroupId - 공유그룹 아이디
  /// @param [String] finalImageUrl - 최종적으로 업로드 할 사진 url
  /// @param [List<int>] taggedProfileId - 태그된 프로필 아이디 리스트
  /// @param [String] accessToken - 사용자 인증을 위한 액세스 토큰
  ///
  /// @return [Map<String, dynamic>?] 서버에서 반환된 정보 (성공 시)
  Future<Map<String, dynamic>?> preSignedUrl(
      String imageName, String accessToken) async {
    try {
      // body 생성
      final body = {
        "imageName": imageName,
      };
      // PresignedURL 요청 API 호출 (Content-Type 제거)
      final response = await _apiService.post(
        '/bundles/preSignedUrl',
        accessToken: accessToken,
        body: body,
      );

      // 응답 파싱
      final responseData = json.decode(response.body);
      print('PresignedURL 요청 성공: ${responseData['data']}');
      return responseData['data'];
    } catch (e) {
      print('PresignedURL 요청 실패: $e');
      return null;
    }
  }
}

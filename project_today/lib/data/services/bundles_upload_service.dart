import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:project_today/data/services/api_service.dart';

class BundlesUploadService {
  final ApiService _apiService = ApiService();

  /// 다이어리 업로드 API 호출 함수
  /// @param [String] shareGroupId - 공유그룹 아이디
  /// @param [String] finalImageUrl - 최종적으로 업로드 할 사진 url
  /// @param [List<int>] taggedProfileId - 태그된 프로필 아이디 리스트
  /// @param [String] accessToken - 사용자 인증을 위한 액세스 토큰
  ///
  /// @return [Map<String, dynamic>?] 서버에서 반환된 정보 (성공 시)
  Future<Map<String, dynamic>?> uploadBundels(
      Int shareGroupId,
      String finalImageUrl,
      List<int> taggedProfileId,
      String accessToken) async {
    try {
      // body 생성
      final body = {
        "shareGroupId": shareGroupId,
        "finalImageUrl": finalImageUrl,
        "taggedProfileId": taggedProfileId
      };
      // 다이어리 업로드 위한 API 호출 (Content-Type 제거)
      final response = await _apiService.post(
        '/bundles/upload',
        accessToken: accessToken,
        body: body,
      );

      // 응답 파싱
      final responseData = json.decode(response.body);
      print('다이어리 업로드 성공: ${responseData['data']}');
      return responseData['data'];
    } catch (e) {
      print('다이어리 업로드 실패: $e');
      return null;
    }
  }
}

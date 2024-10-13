import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_today/data/services/api_service.dart';

class BundleDiariesService {
  final ApiService _apiService = ApiService();

  /// 특정 번들에 속한 다이어리 목록 조회 API 호출 함수
  /// @param [int] bundleId - 조회할 번들의 ID
  /// @param [int] shareGroupId - 조회할 공유 그룹 ID (쿼리 파라미터)
  /// @param [String] accessToken - 사용자 인증을 위한 액세스 토큰
  ///
  /// @return [Map<String, dynamic>?] 서버에서 반환된 다이어리 목록 정보 (성공 시)
  Future<Map<String, dynamic>?> getBundleDiaries(
      int bundleId, int shareGroupId, String accessToken) async {
    try {
      final String endpoint = '/bundles/$bundleId/diaries';

      // 쿼리 파라미터 설정
      final Map<String, String> queryParams = {
        'shareGroupId': shareGroupId.toString(),
      };

      // GET 요청 호출
      final response = await _apiService.get(
        endpoint,
        queryParams: queryParams,
        accessToken: accessToken,
      );

      // 응답 데이터 파싱
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print('다이어리 목록 조회 성공: ${responseData['data']}');
      return responseData['data'];
    } catch (e) {
      print('다이어리 목록 조회 실패: $e');
      return null;
    }
  }
}

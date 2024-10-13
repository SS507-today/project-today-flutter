import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_today/data/services/api_service.dart';

class BundleService {
  final ApiService _apiService = ApiService();

  /// 번들 목록 조회 API 호출 함수
  /// @param [int] shareGroupId - 공유그룹 아이디
  /// @param [int] page - 페이지 번호
  /// @param [int] size - 페이지 당 항목 수
  /// @param [String] accessToken - 사용자 인증을 위한 액세스 토큰
  ///
  /// @return [Map<String, dynamic>?] 서버에서 반환된 번들 정보 (성공 시)
  Future<Map<String, dynamic>?> getBundles(
      int shareGroupId, int page, int size, String accessToken) async {
    try {
      // 쿼리 파라미터 설정
      final queryParams = {
        'shareGroupId': shareGroupId.toString(),
        'page': page.toString(),
        'size': size.toString(),
      };

      // GET 요청 호출
      final response = await _apiService.get(
        '/bundles',
        queryParams: queryParams, // 쿼리 파라미터 추가
        accessToken: accessToken,
      );

      // 응답 데이터 파싱
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print('번들 목록 조회 성공: ${responseData['data']}');
      return responseData['data'];
    } catch (e) {
      print('번들 목록 조회 실패: $e');
      return null;
    }
  }
}

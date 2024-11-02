import 'dart:convert';
import 'package:project_today/data/services/api_service.dart';

///그룹 탈퇴 API
class LeaveShareGroup {
  final ApiService _apiService = ApiService();
// 공유 그룹 탈퇴 API 호출 함수
  /// @param [int] shareGroupId - 탈퇴할 공유 그룹의 ID
  /// @param [String] accessToken - 사용자 인증을 위한 액세스 토큰
  ///
  /// @return [Map<String, dynamic>?] 서버에서 반환된 정보 (성공 시)
  Future<Map<String, dynamic>?> leaveShareGroup(
      int shareGroupId, String accessToken) async {
    try {
      // API DELETE 요청 호출
      final response = await _apiService.delete(
        '/shareGroups/$shareGroupId/leave',
        accessToken: accessToken,
        excludeContentType: true,
      );

      // 응답 파싱
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print('API response: $responseData'); // 응답 로그 추가

      // 성공적으로 삭제 시 데이터 반환
      return responseData['data'];
    } catch (e) {
      print('API 호출 실패: $e');
      return null;
    }
  }
}

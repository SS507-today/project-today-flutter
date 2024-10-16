import 'dart:convert';
import 'package:project_today/data/services/api_service.dart';

/// shareGroupId로 해당 그룹 참여 POST
class PostInviteService {
  final ApiService _apiService = ApiService();

  String _buildInviteEndpoint(int shareGroupId) {
    return '/shareGroups/$shareGroupId/join';
  }

  /// shareGroupId로 해당 그룹 참여 POST
  /// @param [int] shareGroupId - 공유 그룹 id <br />
  /// @param [String] accessToken - 인증을 위한 액세스 토큰<br />
  ///
  /// @return [http.Response] 서버 응답의 data 필드 <br />
  Future<Map<String, dynamic>?> postInvite(
      int shareGroupId, String accessToken) async {
    try {
      final response = await _apiService.post(
        _buildInviteEndpoint(shareGroupId),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      final decodedBody = utf8.decode(response.bodyBytes);
      final responseBody = json.decode(decodedBody);

      return responseBody['data'];
    } catch (e) {
      print('Failed to join group: $e');
      return null;
    }
  }
}

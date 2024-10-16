import 'dart:convert';
import 'package:project_today/data/models/participate_model.dart';
import 'package:project_today/data/services/api_service.dart';

///초대 코드로 그룹 조회 GET
class GetParticipateService {
  final ApiService _apiService = ApiService();

  String _buildCodeEndpoint(String code) {
    return '/shareGroups?inviteCode=$code';
  }

  ///초대 코드로 그룹 조회 GET
  /// @param [String] code - 참가 코드 <br />
  /// @param [String] accessToken - 인증을 위한 액세스 토큰 (옵션). <br />
  ///
  /// @return [http.Response] 서버 응답의 data 필드 <br />
  Future<ParticipateGroup> fetchParticipate(
      String code, String accessToken) async {
    try {
      final response = await _apiService.get(
        _buildCodeEndpoint(code),
        accessToken: accessToken,
      );
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseBody = json.decode(decodedBody);

      return ParticipateGroup.fromJson(responseBody['data']);
    } catch (e) {
      print('Error fetching Participate: $e');
      throw Exception('Failed to load Participate: $e');
    }
  }
}

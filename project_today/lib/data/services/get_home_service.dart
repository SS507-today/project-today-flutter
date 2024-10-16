import 'dart:convert';
import 'package:project_today/data/models/home_model.dart';
import 'package:project_today/data/models/group_status_model.dart';
import 'package:project_today/data/services/api_service.dart';

///홈 화면 데이터 조회 GET
class GetHomeService {
  final ApiService _apiService = ApiService();

  String _buildStatusEndpoint(int groupId) {
    return '/shareGroups/$groupId/status';
  }

  String _buildHomeEndpoint(int groupId) {
    return '/shareGroups/$groupId/home';
  }

  ///그룹 상태 조회 GET <br />
  /// @param [int] groupId - 조회할 shareGroupId <br />
  /// @param [String] accessToken - 인증을 위한 액세스 토큰 <br />
  ///
  /// @return [http.Response] 서버 응답의 data 필드 <br />
  Future<GroupStatus> fetchGroupStatus(int groupId, String accessToken) async {
    try {
      final response = await _apiService.get(
        _buildStatusEndpoint(groupId),
        accessToken: accessToken,
      );
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseBody = json.decode(decodedBody);

      return GroupStatus.fromJson(responseBody['data']);
    } catch (e) {
      print('Error fetching Group Status: $e');
      throw Exception('Failed to load Group Status: $e');
    }
  }

  ///그룹 조회 GET <br />
  /// @param [int] groupId - 조회할 shareGroupId <br />
  /// @param [String] accessToken - 인증을 위한 액세스 토큰 <br />
  ///
  /// @return [http.Response] 서버 응답의 data 필드 <br />
  Future<HomeResponse> fetchGroupHome(int groupId, String accessToken) async {
    try {
      final response = await _apiService.get(
        _buildHomeEndpoint(groupId),
        accessToken: accessToken,
      );
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseBody = json.decode(decodedBody);

      return HomeResponse.fromJson(responseBody['data']);
    } catch (e) {
      print('Error fetching Group Home: $e');
      throw Exception('Failed to load Group Home: $e');
    }
  }
}

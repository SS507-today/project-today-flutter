import 'dart:convert';
import 'package:project_today/data/services/api_service.dart';

class GetRecentBundlesService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>?> getRecentBundleDiaries(
      int shareGroupId, String accessToken) async {
    try {
      const String endpoint = '/bundles/latest';
      final Map<String, String> queryParams = {
        'shareGroupId': shareGroupId.toString(),
      };

      final response = await _apiService.get(
        endpoint,
        queryParams: queryParams,
        accessToken: accessToken,
      );

      final responseData = json.decode(utf8.decode(response.bodyBytes));
      if (responseData['data'] != null) {
        print('최신 다이어리 목록 조회 성공: ${responseData['data']}');
        return responseData['data'];
      }
      return null;
    } catch (e) {
      print('최신 다이어리 목록 조회 실패: $e');
      return null;
    }
  }
}

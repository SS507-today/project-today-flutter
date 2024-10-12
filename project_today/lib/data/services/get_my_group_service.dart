import 'dart:convert';
import 'package:project_today/data/models/group_model.dart';
import 'package:project_today/data/services/api_service.dart';

///내가 속한 그룹 조회 GET
class GetMyGroupService {
  final ApiService _apiService = ApiService();

  static const String groupsEndpoint = 'shareGroups/my?page=0&size=10';

  ///내가 속한 그룹 조회 GET
  Future<List<Group>> fetchGroups(String accessToken) async {
    try {
      final response = await _apiService.get(
        groupsEndpoint,
        accessToken: accessToken,
      );

      final decodedBody = utf8.decode(response.bodyBytes);
      final responseBody = json.decode(decodedBody);

      List<dynamic> data = responseBody['data']['shareGroupInfoList'];

      return data.map((json) => Group.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching Groups: $e');
      throw Exception('Failed to load Groups: $e');
    }
  }
}

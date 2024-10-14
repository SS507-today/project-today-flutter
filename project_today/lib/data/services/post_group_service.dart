import 'dart:convert';
import 'package:project_today/data/models/detail_group_model.dart';
import 'package:project_today/data/services/api_service.dart';

///그룹 생성 POST
class PostGroupService {
  final ApiService _apiService = ApiService();

  ///그룹 생성 POST
  Future<Map<String, dynamic>> createGroup(
      DetailGroupModel group, String accessToken) async {
    try {
      final response = await _apiService.post(
        '/shareGroups',
        body: group.toJson(),
        accessToken: accessToken,
      );
      return json.decode(response.body)['data'];
    } catch (e) {
      throw Exception('Failed to create group: $e');
    }
  }
}

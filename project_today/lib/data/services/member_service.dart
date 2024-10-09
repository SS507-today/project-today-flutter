import 'dart:convert';
import 'package:project_today/data/models/member_model.dart';
import 'package:project_today/data/services/api_service.dart';

/// 유저 목록 데이터를 가져오는 함수
class MemberService {
  final ApiService _apiService = ApiService(); // 공통 ApiService 인스턴스 생성

  static const String membersEndpoint = '/users';

  Future<List<Member>> fetchMembers() async {
    try {
      final response = await _apiService.get(membersEndpoint); //HTTP 메소드
      List<dynamic> data = json.decode(response.body);

      return data.map((json) => Member.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load members: $e');
    }
  }
}

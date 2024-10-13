import 'package:flutter/material.dart';
import 'package:project_today/data/services/get_participate_service.dart';
import 'package:project_today/data/models/participate_model.dart';

/// 참가 코드 입력 뷰 - 유효 코드 시 해당 그룹 정보를 가져옴
class ParticipateViewModel extends ChangeNotifier {
  final GetParticipateService _participateService = GetParticipateService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _inviteCode = '';
  String get inviteCode => _inviteCode;
  set inviteCode(String value) {
    _inviteCode = value;
    notifyListeners();
  }

  Future<ParticipateGroup?> fetchParticipateGroup() async {
    if (_inviteCode.isEmpty) return null;

    _isLoading = true;
    notifyListeners();

    try {
      const String accessToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzNjg5ODcyNzAxIiwiaWF0IjoxNzI4ODIxMzU4LCJleHAiOjE3MzAwMzA5NTh9.ZKuqozlEo2q09_cGzTbq3h56F1wEXCBelyd4tb7Z5Q8';

      final response =
          await _participateService.fetchParticipate(_inviteCode, accessToken);

      if (response.groupName != null) {
        return response;
      } else {
        throw Exception('유효하지 않은 참가 코드');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

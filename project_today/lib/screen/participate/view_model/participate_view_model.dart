import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/data/services/get_participate_service.dart';
import 'package:project_today/data/models/participate_model.dart';
import 'package:project_today/data/repositories/auth_repository.dart';

/// 참가 코드 입력 뷰 - 유효 코드 시 해당 그룹 정보를 가져옴
class ParticipateViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
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
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken == null) {
      Get.snackbar(
        "오류",
        "사용자 정보를 불러오는 중 오류가 발생했습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }

    if (_inviteCode.isEmpty) return null;

    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await _participateService.fetchParticipate(_inviteCode, accessToken);

      if (response.groupName != null) {
        return response;
      } else {
        throw Exception('유효하지 않은 참가 코드');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        "오류",
        "그룹 정보를 불러오는 중 오류가 발생했습니다: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

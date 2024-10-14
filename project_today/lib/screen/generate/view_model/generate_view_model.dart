import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/data/models/detail_group_model.dart';
import 'package:project_today/data/services/post_group_service.dart';
import 'package:project_today/data/repositories/auth_repository.dart';

class GenerateViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final PostGroupService _groupService = PostGroupService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _inviteCode;
  String? get inviteCode => _inviteCode;

  Future<void> createGroup(DetailGroupModel group) async {
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken == null) {
      Get.snackbar(
        "오류",
        "사용자 정보를 불러오는 중 오류가 발생했습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final data = await _groupService.createGroup(group, accessToken);
      _inviteCode = data['inviteCode'];
    } catch (e) {
      print('Error creating group: $e');
      Get.snackbar(
        "오류",
        "그룹 생성 중 오류가 발생했습니다: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

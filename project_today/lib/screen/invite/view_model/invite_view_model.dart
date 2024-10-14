import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/data/services/post_invite_service.dart';
import 'package:project_today/data/repositories/auth_repository.dart';

/// shareGroupId로 조회한 그룹에 참여 가능한지 조회 후 boolean 리턴
class InviteViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final PostInviteService _postInviteService = PostInviteService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> postInvite(int shareGroupId) async {
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken == null) {
      Get.snackbar(
        "오류",
        "사용자 정보를 불러오는 중 오류가 발생했습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await _postInviteService.postInvite(shareGroupId, accessToken);

      if (response != null) {
        return true; // 그룹 참여 성공 시
      } else {
        return false; // 그룹 참여 실패 시
      }
    } catch (e) {
      print('Failed to join group: $e');
      Get.snackbar(
        "오류",
        "그룹 참여 중 오류가 발생했습니다: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

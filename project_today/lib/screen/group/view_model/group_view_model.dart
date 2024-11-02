import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/data/services/get_my_group_service.dart';
import 'package:project_today/data/models/group_model.dart';
import 'package:project_today/data/repositories/auth_repository.dart';

/// 내 그룹 리스트를 불러옴
class GroupViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final GetMyGroupService _service = GetMyGroupService();

  List<Group> _Groups = [];
  bool _isLoading = false;
  bool _disposed = false; // dispose 상태 확인 플래그 추가

  List<Group> get Groups => _Groups;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _disposed = true; // dispose 상태 설정
    super.dispose();
  }

  Future<void> fetchGroups() async {
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
    if (!_disposed) notifyListeners(); // dispose 상태가 아닐 때만 알림

    try {
      _Groups = await _service.fetchGroups(accessToken);
    } catch (e) {
      print('Error fetching Groups: $e');
      Get.snackbar(
        "오류",
        "그룹 정보를 불러오는 중 오류가 발생했습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading = false;
      if (!_disposed) notifyListeners(); // dispose 상태가 아닐 때만 알림
    }
  }
}

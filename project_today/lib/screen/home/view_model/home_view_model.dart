import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/data/models/home_model.dart';
import 'package:project_today/data/models/group_status_model.dart';
import 'package:project_today/data/services/get_home_service.dart';
import 'package:project_today/data/repositories/auth_repository.dart';

///교환일기 홈 - 분기되는 뷰에 대한 모든 정보를 가져옴 (diary, timer, waiting)
class HomeViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final GetHomeService _diaryService = GetHomeService();

  GroupStatus? _groupStatus;
  HomeResponse? _diaryResponse;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  GroupStatus? get groupStatus => _groupStatus;
  HomeResponse? get diaryResponse => _diaryResponse;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  List<Map<String, String?>> get formattedRules {
    if (_diaryResponse != null &&
        _diaryResponse!.shareGroupDetailInfo != null) {
      return [
        {
          'title': '규칙 1',
          'content': _diaryResponse!.shareGroupDetailInfo!.ruleFirst
        },
        {
          'title': '규칙 2',
          'content': _diaryResponse!.shareGroupDetailInfo!.ruleSecond
        },
        {
          'title': '규칙 3',
          'content': _diaryResponse!.shareGroupDetailInfo!.ruleThird
        },
      ];
    }
    return [];
  }

  HomeGroupDetailInfo? get shareGroupInfo {
    return _diaryResponse?.shareGroupDetailInfo;
  }

  CurrentWriter? get currentWriter {
    if (_diaryResponse != null && _diaryResponse!.currentWriter != null) {
      return _diaryResponse!.currentWriter;
    }
    return null;
  }

  DateTime? get openAt {
    return _groupStatus?.openAt;
  }

  Future<void> initializeGroupFlow(int groupId) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken == null) {
      Get.snackbar(
        "오류",
        "사용자 정보를 불러오는 중 오류가 발생했습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      await fetchGroupStatus(groupId, accessToken);
      if (_groupStatus?.status == 'ACTIVE') {
        await fetchGroupHome(groupId, accessToken);
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      Get.snackbar(
        "오류",
        "그룹 상태 또는 홈 정보를 불러오는 중 오류가 발생했습니다: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchGroupStatus(int groupId, String accessToken) async {
    try {
      _groupStatus = await _diaryService.fetchGroupStatus(groupId, accessToken);
    } catch (e) {
      throw Exception('그룹 상태를 불러오는데 실패했습니다.');
    }
  }

  Future<void> fetchGroupHome(int groupId, String accessToken) async {
    try {
      _diaryResponse = await _diaryService.fetchGroupHome(groupId, accessToken);
    } catch (e) {
      throw Exception('홈 화면 정보를 불러오는데 실패했습니다.');
    }
  }
}

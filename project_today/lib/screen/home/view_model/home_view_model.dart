import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/data/models/home_model.dart';
import 'package:project_today/data/models/group_status_model.dart';
import 'package:project_today/data/models/index.dart';
import 'package:project_today/data/repositories/bundles_recent_repository.dart';
import 'package:project_today/data/services/get_home_service.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/repositories/bundles_repository.dart';
import 'package:project_today/data/models/bundles_model.dart';
import 'package:project_today/ui/atoms/index.dart';

///교환일기 홈 - 분기되는 뷰에 대한 모든 정보를 가져옴 (diary, timer, waiting)
class HomeViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final GetHomeService _diaryService = GetHomeService();
  final BundleRepository _bundleRepository = BundleRepository();
  final BundleRecentDiariesRepository _recentDiariesRepository =
      BundleRecentDiariesRepository();
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

  // 최신 다이어리 상태 변수
  BundlesDiaries _recentDiaries = BundlesDiaries(
    shareGroupId: 0,
    bundleId: 0,
    diaries: [],
  );

  int get recentDiaries => _recentDiaries.bundleId;

  // 번들 리스트와 커버 이미지를 위한 상태 변수
  List<BundleInfo> _bundlesList = [];
  int _coverImage = 0;

  // Getter for UI access
  List<BundleInfo> get bundlesList => _bundlesList;
  int get coverImage => _coverImage;

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
      CustomToastManager().showCustomToast(
        message: "사용자 정보를 불러오는 중 오류가 발생했습니다.",
        type: ToastType.NEGATIVE,
      );
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      await fetchGroupStatus(groupId, accessToken);
      await fetchGroupHome(groupId, accessToken);

      if (_groupStatus?.status == 'ACTIVE') {
        //   await fetchGroupHome(groupId, accessToken);
        await fetchBundles(groupId);
        await fetchRecentDiaries(groupId);
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      CustomToastManager().showCustomToast(
        message: "$e",
        type: ToastType.NEGATIVE,
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

  Future<void> fetchBundles(int groupId) async {
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken != null) {
      _isLoading = true;
      notifyListeners();

      try {
        final bundleResponse =
            await _bundleRepository.fetchBundles(groupId, 0, 100, accessToken);

        if (bundleResponse != null) {
          _bundlesList = bundleResponse.bundleInfoList;
          _coverImage = bundleResponse.coverImage;
        } else {
          _errorMessage = "번들 정보를 불러오는 데 실패했습니다.";
          _hasError = true;
        }
      } catch (e) {
        _errorMessage = "번들 정보를 가져오는 중 오류 발생: $e";
        _hasError = true;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  /// 최신 번들 다이어리 목록을 가져오는 메서드
  Future<void> fetchRecentDiaries(int groupId) async {
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken != null) {
      _isLoading = true;
      notifyListeners();

      try {
        // 최신 다이어리 목록 가져오기
        await _recentDiariesRepository.fetchBundleDiaries(groupId, accessToken);
        _recentDiaries = _recentDiariesRepository.bundleRecentDiaries.value;

        print('최신 다이어리 목록 가져오기 성공: ${_recentDiaries.diaries}');
      } catch (e) {
        _hasError = true;
        _errorMessage = "최신 다이어리 목록 가져오는 중 오류 발생: $e";
        print(_errorMessage);
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}

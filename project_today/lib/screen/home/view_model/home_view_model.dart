import 'package:flutter/material.dart';
import 'package:project_today/data/models/home_model.dart';
import 'package:project_today/data/models/group_status_model.dart';
import 'package:project_today/data/services/get_home_service.dart';

///교환일기 홈 - 분기되는 뷰에 대한 모든 정보를 가져옴 (diary, timer, waiting)
class HomeViewModel extends ChangeNotifier {
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

    try {
      await fetchGroupStatus(groupId);
      if (_groupStatus?.status == 'ACTIVE') {
        await fetchGroupHome(groupId);
      }
      _isLoading = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      _isLoading = false;
    }

    notifyListeners();
  }

  Future<void> fetchGroupStatus(int groupId) async {
    try {
      _groupStatus = await _diaryService.fetchGroupStatus(
        groupId,
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzNjg5ODcyNzAxIiwiaWF0IjoxNzI4Mzg3NzI1LCJleHAiOjE3Mjk1OTczMjV9.MjYwVayW2B7TuNaaq3Uy66eTsg6D3Va6hftnc8dR3zg',
      );
    } catch (e) {
      throw Exception('그룹 상태를 불러오는데 실패했습니다.');
    }
  }

  Future<void> fetchGroupHome(int groupId) async {
    try {
      _diaryResponse = await _diaryService.fetchGroupHome(
        groupId,
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzNjg5ODcyNzAxIiwiaWF0IjoxNzI4Mzg3NzI1LCJleHAiOjE3Mjk1OTczMjV9.MjYwVayW2B7TuNaaq3Uy66eTsg6D3Va6hftnc8dR3zg',
      );
    } catch (e) {
      throw Exception('홈 화면 정보를 불러오는데 실패했습니다.');
    }
  }
}

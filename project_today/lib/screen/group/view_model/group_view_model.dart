import 'package:flutter/material.dart';
import 'package:project_today/data/services/get_my_group_service.dart';
import 'package:project_today/data/models/group_model.dart';

/// 내 그룹 리스트를 불러옴
class GroupViewModel extends ChangeNotifier {
  final GetMyGroupService _service = GetMyGroupService();

  List<Group> _Groups = [];
  bool _isLoading = false;

  List<Group> get Groups => _Groups;
  bool get isLoading => _isLoading;

  Future<void> fetchGroups() async {
    _isLoading = true;
    notifyListeners();

    try {
      const String accessToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzNjg5ODcyNzAxIiwiaWF0IjoxNzI4Mzg3NzI1LCJleHAiOjE3Mjk1OTczMjV9.MjYwVayW2B7TuNaaq3Uy66eTsg6D3Va6hftnc8dR3zg';

      _Groups = await _service.fetchGroups(accessToken);
    } catch (e) {
      print('Error fetching Groups: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/data/models/detail_group_model.dart';
import 'package:project_today/data/services/post_group_service.dart';

class GenerateViewModel extends ChangeNotifier {
  final PostGroupService _groupService = PostGroupService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _inviteCode;
  String? get inviteCode => _inviteCode;

  Future<void> createGroup(DetailGroupModel group) async {
    _isLoading = true;
    notifyListeners();

    try {
      const String accessToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzNjg5ODcyNzAxIiwiaWF0IjoxNzI4Mzg3NzI1LCJleHAiOjE3Mjk1OTczMjV9.MjYwVayW2B7TuNaaq3Uy66eTsg6D3Va6hftnc8dR3zg';

      final data = await _groupService.createGroup(group, accessToken);
      _inviteCode = data['inviteCode'];
    } catch (e) {
      print('Error creating group: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

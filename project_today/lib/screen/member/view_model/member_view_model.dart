import 'package:flutter/material.dart';
import 'package:project_today/data/services/member_service.dart';
import 'package:project_today/data/models/member_model.dart';

class MemberViewModel extends ChangeNotifier {
  List<Member> _members = [];
  bool _isLoading = false;

  List<Member> get members => _members;
  bool get isLoading => _isLoading;

  final MemberService _service = MemberService();

  // 멤버 데이터를 불러오는 함수
  Future<void> fetchMembers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _members = await _service.fetchMembers();
      _members = _members.take(6).toList(); // 처음 6개만 가져오도록 필터링
    } catch (e) {
      print('Error fetching members: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

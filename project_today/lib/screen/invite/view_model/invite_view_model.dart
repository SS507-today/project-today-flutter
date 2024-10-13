import 'package:flutter/material.dart';
import 'package:project_today/data/services/post_invite_service.dart';

///shareGroupId로 조회한 그룹에 참여가능한지 조회 후 boolean 리턴
class InviteViewModel extends ChangeNotifier {
  final PostInviteService _postInviteService = PostInviteService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> postInvite(int shareGroupId) async {
    _isLoading = true;
    notifyListeners();

    try {
      const String accessToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzNjg5ODcyNzAxIiwiaWF0IjoxNzI4Mzg3NzI1LCJleHAiOjE3Mjk1OTczMjV9.MjYwVayW2B7TuNaaq3Uy66eTsg6D3Va6hftnc8dR3zg';

      final response =
          await _postInviteService.postInvite(shareGroupId, accessToken);

      if (response != null) {
        return true; // 그룹 참여 성공 시
      } else {
        return false; // 그룹 참여 실패 시
      }
    } catch (e) {
      print('Failed to join group: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

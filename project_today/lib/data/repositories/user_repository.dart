import 'package:project_today/data/models/user_model.dart';
import 'package:project_today/data/services/member_my_service.dart';

/// 사용자 정보 조회 로직을 담당하는 리포지토리 클래스
class UserRepository {
  final MemberMyService _memberMyService = MemberMyService();

  /// 사용자 정보 조회 및 User 객체 반환
  Future<User?> getUserInfo(String accessToken) async {
    try {
      // Service에서 사용자 정보 가져오기
      final userData = await _memberMyService.fetchMemberMyInfo(accessToken);

      // User 객체로 변환하여 반환
      if (userData != null) {
        return User.fromJson(userData);
      } else {
        print('유효한 사용자 정보를 찾을 수 없습니다.');
        return null;
      }
    } catch (e) {
      print('유저 정보 처리 중 오류 발생: $e');
      return null;
    }
  }
}

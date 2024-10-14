import 'package:project_today/data/services/nickname_service.dart';

class NickNameRepository {
  final NickNameService _nickNameService = NickNameService();

  /// 닉네임 설정을 처리하는 함수
  Future<bool> setNickName(String nickname, String accessToken) async {
    try {
      final response =
          await _nickNameService.setNickName(nickname, accessToken);

      // 응답이 null인지 확인
      if (response == null) {
        print('닉네임 설정 응답이 null입니다.');
        return false;
      }

      // 닉네임 설정 성공 여부 판단
      print('닉네임 설정 성공');
      return true;
    } catch (e) {
      print('닉네임 설정 중 오류 발생: $e');
      return false;
    }
  }
}

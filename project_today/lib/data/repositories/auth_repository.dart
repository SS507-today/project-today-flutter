import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_today/data/services/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  /// 서버로 카카오 액세스 토큰 전송하고 JWT 토큰 받기
  Future<String?> sendTokenToServer(String kakaoAccessToken) async {
    final String endpoint = '/login/oauth/kakao';

    final body = {
      'accessToken': kakaoAccessToken,
    };

    try {
      // ApiService의 POST 메서드 사용
      final response = await _apiService.post(
        endpoint,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['data']['accessToken']; // 서버에서 반환된 JWT 토큰 반환
      } else {
        print('서버 통신 실패: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('서버 요청 중 오류 발생: $e');
      return null;
    }
  }

  /// 로컬 저장소에 토큰 저장
  Future<void> saveTokens(String jwtAccessToken, String kakaoAccessToken,
      String refreshToken, String authId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtAccessToken', jwtAccessToken);
    await prefs.setString('kakaoAccessToken', kakaoAccessToken);
    await prefs.setString('refreshToken', refreshToken);
    await prefs.setString('authId', authId);
  }

  /// 로컬 저장소에서 토큰 불러오기
  Future<Map<String, String?>> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'jwtAccessToken': prefs.getString('jwtAccessToken'),
      'refreshToken': prefs.getString('refreshToken'),
      'authId': prefs.getString('authId'),
    };
  }

  /// 회원가입 여부 확인 API 호출
  Future<bool> checkSignUpStatus(String? authId) async {
    final String endpoint = '/auth/check-registration';

    final longAuthId = int.tryParse(authId!); // String을 int로 변환 시도
    if (longAuthId == null) {
      print('authId 변환 실패: 유효하지 않은 authId입니다. $longAuthId');
      return false;
    }

    // 요청 본문 데이터
    final body = {
      'authId': longAuthId,
    };

    try {
      final response = await _apiService.post(
        endpoint,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['data']['isRegistered'] ?? false; // 회원가입 상태
      } else {
        print('회원가입 확인 실패: ${response.body}');
        return false;
      }
    } catch (e) {
      print('서버 요청 중 오류 발생: $e');
      return false;
    }
  }
}

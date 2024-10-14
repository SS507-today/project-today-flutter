import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_today/data/services/api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService(); // ApiService 인스턴스 생성

  /// 카카오 로그인 처리
  Future<OAuthToken?> loginWithKakao() async {
    try {
      if (await isKakaoTalkInstalled()) {
        return await UserApi.instance.loginWithKakaoTalk();
      } else {
        return await UserApi.instance.loginWithKakaoAccount();
      }
    } catch (error) {
      print('카카오 로그인 중 오류: $error');
      return null;
    }
  }

  /// 카카오 사용자 정보 가져오기
  Future<User?> getKakaoUserInfo() async {
    try {
      return await UserApi.instance.me();
    } catch (error) {
      print('사용자 정보 가져오기 실패: $error');
      return null;
    }
  }

  /// 리프레시 토큰으로 액세스 토큰 갱신
  Future<String?> refreshKakaoAccessToken(String? refreshToken) async {
    final url = 'https://kauth.kakao.com/oauth/token';
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      'grant_type': 'refresh_token',
      'client_id': dotenv.env['KAKAO_NATIVE_APP_KEY'],
      'refresh_token': refreshToken,
    };

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['access_token'];
      } else {
        print('토큰 갱신 실패: ${response.body}');
        return null;
      }
    } catch (e) {
      print('서버 요청 중 오류 발생: $e');
      return null;
    }
  }

  /// 카카오 액세스 토큰을 서버로 전송
  Future<String?> sendTokenToServer(String kakaoAccessToken) async {
    final endpoint = '/login/oauth/kakao'; // 서버 엔드포인트

    // POST 요청 본문 데이터 설정
    final body = {'accessToken': kakaoAccessToken};

    try {
      // ApiService의 POST 메서드 사용
      final response = await _apiService.post(
        endpoint,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['data']['accessToken']; // 서버에서 반환된 JWT 토큰
      } else {
        print('서버 통신 실패: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('서버 요청 중 오류 발생: $e');
      return null;
    }
  }
}

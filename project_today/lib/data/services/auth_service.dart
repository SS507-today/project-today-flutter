import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // TODO : localhost 부분에 ip주소 또는 10.0.2.2
  final String _apiBaseUrl = 'http://localhost:8080'; // 서버의 베이스 URL

  /// 카카오 로그인 로직
  Future<void> loginWithKakao(BuildContext context) async {
    try {
      OAuthToken token;
      if (await isKakaoTalkInstalled()) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
          print('>>>>>카카오톡으로 로그인 성공: ${token.accessToken}');
        } catch (error) {
          print('>>>>>카카오톡으로 로그인 실패: $error');
          token = await UserApi.instance.loginWithKakaoAccount();
          print('>>>>>카카오계정으로 로그인 성공1: ${token.accessToken}');
        }
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
        print('>>>>>카카오계정으로 로그인 성공2: ${token.accessToken}');
      }

      if (token != null) {
        // 카카오 사용자 정보 가져오기
        User user = await UserApi.instance.me();
        String authId = user.id.toString();
        print('카카오 사용자 고유 ID: $authId');

        // 서버로 카카오 액세스 토큰 전송
        String? serverAccessToken = await sendTokenToServer(token.accessToken);

        if (serverAccessToken != null) {
          // 토큰과 사용자 정보를 로컬에 저장
          await saveTokens(serverAccessToken, token.accessToken,
              token.refreshToken!, authId);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('회원가입 성공!'),
              duration: Duration(seconds: 2), // 스낵바 노출 시간
              backgroundColor: Colors.green, // 배경 색상
            ),
          );

          Navigator.pushReplacementNamed(context, '/onboard');
        } else {
          print('서버로부터 액세스 토큰을 받아오지 못했습니다.');
        }
      }
    } catch (error) {
      print('>>>>>로그인 중 오류 발생: $error');
    }
  }

  /// 카카오 액세스 토큰을 서버로 전송
  Future<String?> sendTokenToServer(String kakaoAccessToken) async {
    final String url = '$_apiBaseUrl/login/oauth/kakao';
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'accept': '*/*',
    };

    final body = json.encode({
      'accessToken': kakaoAccessToken,
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String serverAccessToken = responseData['data']['accessToken'];
        print('서버에서 반환된 Access Token: $serverAccessToken');
        return serverAccessToken;
      } else {
        print('로그인 실패: ${response.statusCode}');
        print('응답 메시지: ${response.body}');
        return null;
      }
    } catch (e) {
      print('서버 요청 중 오류 발생: $e');
      return null;
    }
  }

  /// JWT 토큰과 사용자 ID를 로컬 저장소에 저장하는 함수
  Future<void> saveTokens(String serverAccessToken, String kakaoAccessToken,
      String refreshToken, String authId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('serverAccessToken', serverAccessToken);
    await prefs.setString('kakaoAccessToken', kakaoAccessToken);
    await prefs.setString('refreshToken', refreshToken);
    await prefs.setString('authId', authId);
    print('토큰과 사용자 ID가 로컬에 저장되었습니다.');
  }

  /// 로컬 저장소에서 토큰 불러오기
  Future<Map<String, String?>> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('serverAccessToken');
    final refreshToken = prefs.getString('refreshToken');
    final authId = prefs.getString('authId');
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'authId': authId,
    };
  }

  /// 회원가입 여부 확인 API 호출 함수
  Future<bool> checkSignUpStatus(String? authId) async {
    final url = '$_apiBaseUrl/auth/check-registration';
    final headers = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };
    final body = json.encode({'authId': authId});

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['data']['isRegistered'] ?? false;
      } else {
        print('회원가입 확인 실패: ${response.body}');
        return false;
      }
    } catch (e) {
      print('서버 요청 중 오류 발생: $e');
      return false;
    }
  }

  /// 리프레시 토큰으로 액세스 토큰 갱신
  Future<String?> refreshAccessToken(String? refreshToken) async {
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

  /// 사용자 상태 확인 및 화면 이동 로직 분리
  Future<void> checkUserStatus(BuildContext context) async {
    // 로컬 저장소에서 토큰 불러오기
    final tokens = await loadTokens();
    final accessToken = tokens['accessToken'];
    final refreshToken = tokens['refreshToken'];
    final authId = tokens['authId'];

    print('불러온 토큰: $accessToken, 리프레시 토큰: $refreshToken, 사용자 ID: $authId');

    if (accessToken == null || authId == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    // 회원가입 여부 확인 API 호출
    bool isSignedUp = await checkSignUpStatus(authId);
    if (isSignedUp) {
      // 회원가입 되어있다면 토큰 갱신
      await handleTokenRefresh(context, refreshToken);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  /// 리프레시 토큰으로 액세스 토큰 갱신 및 화면 전환
  Future<void> handleTokenRefresh(
      BuildContext context, String? refreshToken) async {
    if (refreshToken == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    // 새로운 액세스 토큰 요청
    String? newAccessToken = await refreshAccessToken(refreshToken);

    if (newAccessToken != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('serverAccessToken', newAccessToken); // 갱신된 토큰 저장
      Navigator.pushReplacementNamed(context, '/group');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}

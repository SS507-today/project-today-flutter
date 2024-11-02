import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_today/data/services/auth_service.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/models/user_model.dart';
import 'package:project_today/data/repositories/user_repository.dart';
import 'package:project_today/screen/login/view/login_view.dart';
import 'package:project_today/ui/atoms/index.dart';

class SettingViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();
  final AuthService _authService = AuthService();

  var user = User(
    authId: 0,
    email: '',
    image: '',
    platform: '',
    refreshToken: '',
    name: '',
    nickname: '',
  ).obs;

  var isLoading = true.obs; // 로딩 상태

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo(); // 초기화 시 데이터 로드
  }

  /// 화면이 다시 활성화될 때마다 사용자 정보 다시 가져오기
  @override
  void onReady() {
    super.onReady();
    fetchUserInfo(); // 화면이 준비될 때마다 사용자 정보 로드
  }

  /// Repository를 통해 사용자 정보 가져오기
  Future<void> fetchUserInfo() async {
    isLoading.value = true; // 데이터 로딩 시작
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken != null) {
      try {
        final fetchedUser = await _userRepository.getUserInfo(accessToken);
        if (fetchedUser != null) {
          user.value = fetchedUser;
        } else {
          Get.snackbar(
            "오류",
            "사용자 정보를 불러오는 데 실패했습니다.",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        Get.snackbar(
          "오류",
          "사용자 정보를 불러오는 중 오류가 발생했습니다: $e",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "오류",
        "액세스 토큰을 찾을 수 없습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false; // 데이터 로딩 완료
  }

  /// 로그아웃 처리
  Future<void> logout(BuildContext context) async {
    final success = await _authService.logoutFromKakao();
    if (success) {
      await _authRepository.clearTokens(); // 저장된 토큰 제거

      CustomToastManager().showCustomToast(
        message: "로그아웃 성공",
        type: ToastType.POSITIVE,
      );

      // 쌓여 있는 모든 라우트를 제거하고 로그인 화면으로 이동
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoginView()), // LoginView를 직접 지정
        (Route<dynamic> route) => false,
      );
    } else {
      CustomToastManager().showCustomToast(
        message: "로그아웃 실패",
        type: ToastType.NEGATIVE,
      );
    }
  }
}

import 'package:get/get.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/models/user_model.dart';
import 'package:project_today/data/repositories/user_repository.dart';

class SettingViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  var user = User(
    authId: 0,
    email: '',
    image: '',
    platform: '',
    refreshToken: '',
    name: '',
    nickname: '',
  ).obs;

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
  }
}

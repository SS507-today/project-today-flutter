import 'package:get/get.dart';
import 'package:project_today/data/repositories/bundles_diary_repository.dart';
import 'package:project_today/data/models/bundles_diaries_model.dart';
import 'package:project_today/data/repositories/auth_repository.dart';

class ReadViewModel extends GetxController {
  final BundleDiariesRepository _bundleDiariesRepository =
      BundleDiariesRepository();
  final AuthRepository _authRepository = AuthRepository();

  var diaries = <Diary>[].obs;
  var isLoading = false.obs;

  Future<void> fetchDiaryData(int bundleId, int shareGroupId) async {
    isLoading.value = true;
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken != null) {
      try {
        await _bundleDiariesRepository.fetchBundleDiaries(
          bundleId,
          shareGroupId,
          accessToken,
        );
        diaries.value = _bundleDiariesRepository.getDiaries();
      } catch (e) {
        print("다이어리 데이터 로드 중 오류: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }
}

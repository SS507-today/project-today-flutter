import 'package:get/get.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/repositories/bundles_repository.dart';
import 'package:project_today/data/models/bundles_model.dart';
import 'package:project_today/data/repositories/current_group_id_repository.dart'
    as globals;

class CollectionViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final BundleRepository _bundleRepository = BundleRepository();

  var bundlesList = <BundleInfo>[].obs;
  var coverImage = 0.obs; // 커버 이미지를 추가하여 관리

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(globals.currentGroupId, (_) {
      fetchBundles();
    });
    // 초기화 시 번들 정보 불러오기
    fetchBundles();
  }

  Future<void> fetchBundles() async {
    isLoading.value = true;

    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken != null) {
      try {
        final shareGroupId = globals.currentGroupId.value; // RxInt로 접근

        final bundleResponse = await _bundleRepository.fetchBundles(
            shareGroupId, 0, 100, accessToken);

        if (bundleResponse != null) {
          bundlesList.value = bundleResponse.bundleInfoList;
          coverImage.value = bundleResponse.coverImage; // 커버 이미지 설정
        } else {
          print("CollectionViewModel 번들 정보를 불러오는 데 실패했습니다.");
        }
      } catch (e) {
        print("CollectionViewModel 번들 정보를 가져오는 중 오류 발생: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }
}

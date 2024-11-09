import 'package:get/get.dart';
import 'package:project_today/data/models/bundles_diaries_model.dart';
import 'package:project_today/data/services/get_recent_bundles_service.dart';

class BundleRecentDiariesRepository {
  final GetRecentBundlesService _bundleRecentDiariesService =
      GetRecentBundlesService();

  /// 다이어리 목록을 관리하는 상태 변수
  var bundleRecentDiaries = BundlesDiaries(
    shareGroupId: 0,
    bundleId: 0,
    diaries: [],
  ).obs;

  /// 특정 번들에 속한 다이어리 목록을 불러와서 저장하는 함수
  Future<void> fetchBundleDiaries(int shareGroupId, String accessToken) async {
    try {
      // 서버에서 최신 다이어리 목록을 가져옴
      final result = await _bundleRecentDiariesService.getRecentBundleDiaries(
        shareGroupId,
        accessToken,
      );

      if (result != null) {
        // 서버에서 받은 데이터를 모델로 변환하여 상태 변수에 저장
        bundleRecentDiaries.value = BundlesDiaries.fromJson(result);
        print('최신 다이어리 목록 저장 성공');
        print('Diaries: ${bundleRecentDiaries.value.diaries}');
      } else {
        print('최신 다이어리 목록을 받아오지 못했습니다.');
      }
    } catch (e) {
      print('최신 다이어리 목록 저장 실패: $e');
    }
  }

  /// 저장된 다이어리 목록을 반환하는 함수
  List<Diary> getDiaries() {
    return bundleRecentDiaries.value.diaries;
  }

  /// 저장된 다이어리 목록을 초기화하는 함수 (필요 시)
  void clearDiaries() {
    bundleRecentDiaries.value = BundlesDiaries(
      shareGroupId: 0,
      bundleId: 0,
      diaries: [],
    );
  }
}

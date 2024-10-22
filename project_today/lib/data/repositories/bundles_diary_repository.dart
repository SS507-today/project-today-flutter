import 'package:get/get.dart';
import 'package:project_today/data/services/bundles_diaries_service.dart';
import 'package:project_today/data/models/bundles_diaries_model.dart';

class BundleDiariesRepository {
  final BundleDiariesService _bundleDiariesService = BundleDiariesService();

  /// 다이어리 목록을 관리하는 상태 변수
  var bundleDiaries = BundlesDiaries(
    shareGroupId: 0,
    bundleId: 0,
    diaries: [],
  ).obs;

  /// 특정 번들에 속한 다이어리 목록을 불러와서 저장하는 함수
  Future<void> fetchBundleDiaries(
      int bundleId, int shareGroupId, String accessToken) async {
    try {
      final result = await _bundleDiariesService.getBundleDiaries(
        bundleId,
        shareGroupId,
        accessToken,
      );
      if (result != null) {
        // 서버에서 받아온 다이어리 목록을 모델로 변환하여 상태 변수에 저장
        bundleDiaries.value = BundlesDiaries.fromJson({
          'shareGroupId': shareGroupId,
          'bundleId': bundleId,
          'diaries': result['diaries'],
        });
        print('다이어리 목록 저장 성공');
        print('Diaries: ${bundleDiaries.value.diaries}');
      } else {
        print('다이어리 목록을 받아오지 못했습니다.');
      }
    } catch (e) {
      print('다이어리 목록 저장 실패: $e');
    }
  }

  /// 저장된 다이어리 목록을 반환하는 함수
  List<Diary> getDiaries() {
    return bundleDiaries.value.diaries;
  }

  /// 저장된 다이어리 목록을 초기화하는 함수 (필요 시)
  void clearDiaries() {
    bundleDiaries.value = BundlesDiaries(
      shareGroupId: 0,
      bundleId: 0,
      diaries: [],
    );
  }
}

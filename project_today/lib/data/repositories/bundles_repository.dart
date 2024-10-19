import 'package:project_today/data/models/bundles_model.dart';
import 'package:project_today/data/services/bundles_service.dart';

class BundleRepository {
  final BundleService _bundleService = BundleService();

  /// 번들 목록을 가져오는 함수
  /// @param [int] shareGroupId - 공유 그룹 ID
  /// @param [int] page - 페이지 번호
  /// @param [int] size - 페이지 당 항목 수
  /// @param [String] accessToken - 사용자 인증을 위한 액세스 토큰
  ///
  /// @return [BundlesModel?] 번들 목록을 반환하는 함수
  Future<BundleModel?> fetchBundles(
      int shareGroupId, int page, int size, String accessToken) async {
    try {
      final responseData = await _bundleService.getBundles(
        shareGroupId,
        page,
        size,
        accessToken,
      );

      // 응답 데이터가 있으면 BundlesModel로 변환
      if (responseData != null) {
        return BundleModel.fromJson(responseData);
      } else {
        print('번들 데이터를 불러오지 못했습니다.');
        return null;
      }
    } catch (e) {
      print('BundleRepository에서 오류 발생: $e');
      return null;
    }
  }
}

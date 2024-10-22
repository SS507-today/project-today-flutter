import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_today/data/services/api_service.dart';

class BundlesUploadService {
  final ApiService _apiService = ApiService();

  /// 다이어리 업로드 API 호출 함수
  Future<Map<String, dynamic>?> uploadBundels(
      int shareGroupId,
      String finalImageUrl,
      List<int> taggedProfileId,
      String accessToken) async {
    try {
      // body 생성
      final body = {
        "shareGroupId": shareGroupId,
        "finalImageUrl": finalImageUrl,
        "taggedProfileId": taggedProfileId
      };

      // 다이어리 업로드 위한 API 호출
      final response = await _apiService.post(
        '/bundles/upload',
        accessToken: accessToken,
        body: body,
      );

      // 여기서 예외를 던지지 않도록 직접 처리
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // 성공 시 데이터 파싱
        final responseData = json.decode(response.body); // UTF-8 디코딩 없이 처리
        print('다이어리 업로드 성공: ${responseData['data']}');
        return responseData;
      } else {
        // 실패 시 서버의 에러 메시지를 UTF-8로 변환
        final rawErrorMessage =
            utf8.decode(response.bodyBytes, allowMalformed: true);
        print('다이어리 업로드 실패: $rawErrorMessage');

        // 실패 메시지 반환
        return {
          'status': response.statusCode,
          'message': rawErrorMessage, // 그대로 사용
        };
      }
    } catch (e) {
      print('다이어리 업로드 중 오류 발생: $e');
      return {
        'status': 500,
        'message': '다이어리 업로드 중 오류가 발생했습니다.',
      };
    }
  }
}

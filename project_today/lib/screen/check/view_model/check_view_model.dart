import 'dart:typed_data';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:project_today/data/repositories/auth_repository.dart';
import 'package:project_today/data/services/index.dart';
import 'package:project_today/data/repositories/member_repository.dart';
import 'package:project_today/data/repositories/current_group_id_repository.dart'
    as globals;
import 'package:project_today/data/models/index.dart';
import 'package:project_today/ui/atoms/atoms.dart';

class CheckViewModel extends GetxController {
  final BundlesPresignedService _presignedService = BundlesPresignedService();
  final BundlesUploadService _uploadService = BundlesUploadService();
  final MemberRepository _memberRepository = MemberRepository();
  final AuthRepository _authRepository = AuthRepository();

  var members = <GroupProfile>[].obs;
  var isLoading = true.obs;

  // 반응형 currentGroupId 사용
  var currentGroupId = globals.currentGroupId; // 전역 RxInt를 가져옴

  @override
  void onInit() {
    super.onInit();
    ever(currentGroupId, (_) => fetchMembers());
    fetchMembers();
  }

  /// 멤버 데이터를 가져오는 함수
  Future<void> fetchMembers() async {
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken != null) {
      try {
        final fetchedMembers = await _memberRepository.fetchProfilesList(
          currentGroupId.value, // 반응형 그룹 ID 사용
          accessToken,
        );
        if (fetchedMembers != null) {
          members.value = fetchedMembers;
          isLoading.value = false;
        }
      } catch (e) {
        print('Error fetching members: $e');
      }
    }
  }

  // Uint8List 데이터를 임시 파일로 저장하는 함수
  Future<File> _writeImageToFile(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/uploaded_image.jpg').create();
    file.writeAsBytesSync(imageData);
    return file;
  }

  /// Presigned PUT 방식으로 이미지 업로드 함수
  Future<bool> uploadImageWithPresignedPut(
      String presignedUrl, Uint8List imageData) async {
    try {
      String cleanedUrl = presignedUrl.split('&x-amz-acl=public-read')[0];
      var response = await http.put(
        Uri.parse(cleanedUrl),
        body: imageData,
        headers: {
          'Content-Type': 'image/jpeg',
        },
      );
      if (response.statusCode == 200) {
        print('Image upload successful');
        return true; // 성공 시 true 반환
      } else {
        print('Image upload failed: ${response.body}');
        return false; // 실패 시 false 반환
      }
    } catch (e) {
      print('Error uploading image: $e');
      return false; // 예외 발생 시 false 반환
    }
  }

  /// 다이어리 업로드 함수
  Future<void> uploadDiary(Uint8List imageData) async {
    final tokens = await _authRepository.loadTokens();
    final String? accessToken = tokens['jwtAccessToken'];

    if (accessToken != null) {
      try {
        String imageName = "uploaded.jpg";
        final presignedData =
            await _presignedService.preSignedUrl(imageName, accessToken);

        if (presignedData != null && presignedData['preSignedUrl'] != null) {
          String presignedUrl = presignedData['preSignedUrl'];

          // 이미지 업로드가 성공할 경우에만 다이어리 업로드 진행
          bool isUploadSuccessful =
              await uploadImageWithPresignedPut(presignedUrl, imageData);

          if (!isUploadSuccessful) {
            print('Image upload failed, aborting diary upload');
            CustomToastManager().showCustomToast(
              message: '다이어리 업로드 실패',
              type: ToastType.NEGATIVE,
            );
            return; // 이미지 업로드 실패 시 다이어리 업로드 중단
          }

          String finalImageUrl = presignedUrl.split('?')[0];
          List<int> taggedProfileIds =
              members.map((member) => member.profileId).toList();

          final diaryUploadResponse = await _uploadService.uploadBundels(
            currentGroupId.value, // 반응형 그룹 ID 사용
            finalImageUrl,
            taggedProfileIds,
            accessToken,
          );

          if (diaryUploadResponse != null) {
            if (diaryUploadResponse['status'] == 200) {
              String successMessage =
                  diaryUploadResponse['message'] ?? '다이어리 업로드 성공';
              print("Diary upload successful: $successMessage");
              CustomToastManager().showCustomToast(
                message: successMessage,
                type: ToastType.POSITIVE,
              );
            } else {
              // UTF-8로 인코딩된 메시지를 디코딩하여 표시
              String decodedMessage =
                  utf8.decode(diaryUploadResponse['message'].runes.toList());
              print("Diary upload failed: $decodedMessage");

              CustomToastManager().showCustomToast(
                message: decodedMessage, // 디코딩된 에러 메시지 출력
                type: ToastType.NEGATIVE,
              );
            }
          } else {
            print("Diary upload failed");
            CustomToastManager().showCustomToast(
              message: '다이어리 업로드 실패',
              type: ToastType.NEGATIVE,
            );
          }
        }
      } catch (e) {
        print("Error uploading diary: $e");
        CustomToastManager().showCustomToast(
          message: '다이어리 업로드 중 오류 발생',
          type: ToastType.NEGATIVE,
        );
      }
    }
  }
}

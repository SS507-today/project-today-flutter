import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';

Future<void> uploadImageWithPresignedPost(
    String presignedUrl, Map<String, dynamic> fields, File imageFile) async {
  var request = http.MultipartRequest('POST', Uri.parse(presignedUrl));

  // Presigned POST fields 추가
  fields.forEach((key, value) {
    request.fields[key] = value;
  });

  // 이미지 파일 추가
  request.files.add(
    await http.MultipartFile.fromPath('file', imageFile.path),
  );

  // 요청 전송
  var response = await request.send();

  if (response.statusCode == 204) {
    print("File uploaded successfully.");
  } else {
    print("File upload failed with status: ${response.statusCode}");
  }
}

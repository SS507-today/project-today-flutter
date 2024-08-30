import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pro_image_editor/models/editor_callbacks/pro_image_editor_callbacks.dart';
import 'package:pro_image_editor/modules/main_editor/main_editor.dart';
import 'package:project_today/screen/write/write_screens2.dart';

class WriteScreen extends StatefulWidget {
  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  Uint8List? editedBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProImageEditor.network(
        'https://picsum.photos/id/237/2000',
        callbacks: ProImageEditorCallbacks(
          onImageEditingComplete: (Uint8List bytes) async {
            print('Image editing completed.');
            print('Image size in bytes: ${bytes.length}');

            editedBytes = bytes;
          },
          onCloseEditor: () {
            if (editedBytes != null) {
              // 이미지가 null이 아닐 때 다음 화면으로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => WriteScreen2(imageData: editedBytes!),
                ),
              );
            } else {
              // 이미지가 null일 경우 현재 화면을 닫음
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}

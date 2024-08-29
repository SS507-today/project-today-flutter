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
  final GlobalKey<ProImageEditorState> editorKey =
      GlobalKey<ProImageEditorState>();
  Uint8List? editedBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProImageEditor.network(
        'https://picsum.photos/id/237/2000',
        key: editorKey,
        callbacks: ProImageEditorCallbacks(
          onImageEditingComplete: (Uint8List bytes) async {
            print('Image editing completed.');
            print('Image size in bytes: ${bytes.length}');

            try {
              editedBytes = bytes;

              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WriteScreen2(imageData: editedBytes!),
                  ),
                );
              } else {
                print('Widget is not mounted.');
              }
            } catch (error) {
              print('Navigation Error: $error');
            }
          },
        ),
      ),
    );
  }
}

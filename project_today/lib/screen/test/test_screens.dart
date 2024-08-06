import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pro_image_editor/models/editor_callbacks/pro_image_editor_callbacks.dart';
import 'package:pro_image_editor/modules/main_editor/main_editor.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProImageEditor.network(
        'https://picsum.photos/id/237/2000',
        callbacks: ProImageEditorCallbacks(
          onImageEditingComplete: (Uint8List bytes) async {
            /*
                 Your code to handle the edited image. Upload it to your server as an example.
                 You can choose to use await, so that the loading-dialog remains visible until your code is ready, or no async, so that the loading-dialog closes immediately.
                 By default, the bytes are in `jpg` format.
                */
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

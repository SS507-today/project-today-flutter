import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/ui/templates/index.dart';
import 'package:project_today/screen/check/view_model/check_view_model.dart';

class CheckView extends StatelessWidget {
  final Uint8List imageData;

  const CheckView({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CheckViewModel viewModel = Get.put(CheckViewModel());

    return Scaffold(
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Checktemplate(
          imageData: imageData,
          onCompleteIconPressed: () {
            print("Upload button pressed");
            viewModel.uploadDiary(
              imageData,
            );
          },
          members: viewModel.members
              .map((member) =>
                  {'name': member.profileNickName, 'imgPath': member.image})
              .toList(),
        );
      }),
    );
  }
}

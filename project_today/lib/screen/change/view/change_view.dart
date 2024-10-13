import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/screen/change/view_model/change_view_model.dart';
import 'package:project_today/ui/templates/index.dart';

class ChangeView extends StatelessWidget {
  final ChangeViewModel _changeViewModel = Get.put(ChangeViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ChangeTemplate(
        isButtonActive: _changeViewModel.isButtonActive.value,
        onNicknameChanged: _changeViewModel.onNicknameChanged,
        onNextPressed: () async {
          // 비동기 함수 호출
          await _changeViewModel.onNextPressed(context);
        },
      ),
    );
  }
}

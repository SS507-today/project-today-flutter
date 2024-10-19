import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/ui/templates/index.dart';
import 'package:project_today/screen/prev/view_model/prev_view_model.dart'; // ViewModel import

class PrevView extends StatelessWidget {
  final PrevViewModel _viewModel = Get.put(PrevViewModel()); // ViewModel 초기화

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Tabbartemplate(
          headerTitle: '일기장',
          groupName: _viewModel.groupName.value.isEmpty
              ? 'Loading...'
              : _viewModel.groupName.value,
          groupDes: _viewModel.groupDescription.value.isEmpty
              ? 'Loading...'
              : _viewModel.groupDescription.value,
        );
      }),
    );
  }
}

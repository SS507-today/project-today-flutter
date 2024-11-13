import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/index.dart';
import 'package:provider/provider.dart';
import 'package:project_today/screen/home/view_model/home_view_model.dart';

/// 교환일기 홈에서 분기 - 다이어리가 아직 안 열렸을 때
class TimerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Diaryhometemplate(
        headerTitle: viewModel.groupName ?? '그룹 이름 없음',
        topText: "친구들이 모두 들어오면\n교환일기가 시작돼요!",
        createdAt: viewModel.openAt,
        imgPath: 'assets/images/waiting.png',
        isActive: false,
        onPressed: () {});
  }
}

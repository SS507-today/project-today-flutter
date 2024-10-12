import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_today/screen/home/view_model/home_view_model.dart';
import 'package:project_today/ui/templates/index.dart';

/// 교환일기 홈에서 분기 - 다이어리에서 내 차례 일 때
class DiaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Diaryhometemplate(
          headerTitle: 'SS507',
          topText: "새로운 일기를 담은\n교환일기가 도착했어요!",
          showGlowGradientBox: true,
          onTapGradientBox: () {
            Navigator.pushNamed(context, '/read');
          },
          imgPath:
              'assets/images/cover/group_${viewModel.shareGroupInfo?.coverImage}.png',
          imgWidth: 229,
          rules: viewModel.formattedRules,
          onPressed: () {
            Navigator.pushNamed(context, '/prev');
          },
        );
      },
    );
  }
}

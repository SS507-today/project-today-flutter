import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_today/screen/home/view_model/home_view_model.dart';
import 'package:project_today/ui/templates/index.dart';
import 'package:project_today/ui/organisms/titleCardRule.dart';

/// 교환일기 홈에서 분기 - 다이어리에서 내 차례 아닐 때
class WaitingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Diaryhometemplate(
      headerTitle: 'SS507',
      name: viewModel.currentWriter?.name ?? '알 수 없음',
      topText: "님이 일기를 쓰고 있어요",
      bottomText: "눌러서 재촉해보세요!",
      imgPath: 'assets/images/kock.png',
      onPressed: () {},
      profileData: ProfileData(
        imgPath: viewModel.currentWriter?.image ?? '',
        title: viewModel.currentWriter?.name ?? '알 수 없음',
        desc: viewModel.currentWriter?.description ?? '설명 없음',
      ),
    );
  }
}

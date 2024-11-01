import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_today/screen/home/diary_screens.dart';
import 'package:project_today/screen/home/timer_screens.dart';
import 'package:project_today/screen/home/waiting_screens.dart';
import 'package:project_today/screen/home/view_model/home_view_model.dart';
import 'package:project_today/data/repositories/current_group_id_repository.dart'
    as globals;

///교환일기 홈 - 상태에 따라 스크린 분기 (diary, timer, waiting)
class HomeView extends StatelessWidget {
  final int groupId;

  HomeView({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel()..initializeGroupFlow(groupId),
      child: Scaffold(
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            globals.currentGroupId.value = groupId;
            print("현재 그룹 id: ${globals.currentGroupId}");

            // 데이터 로딩 중일 때 로딩 인디케이터 표시
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (viewModel.hasError) {
              return Center(child: Text('${viewModel.errorMessage}'));
            }

            // 그룹 상태를 확인
            final groupStatus = viewModel.groupStatus;

            if (groupStatus == null) {
              return Center(child: Text('그룹 정보를 불러올 수 없습니다.'));
            }

            // PENDING 상태일 경우, TimerScreen 표시
            if (groupStatus.status == 'PENDING') {
              return TimerView();
            }

            // ACTIVE 상태일 경우 내 차례인지 확인하여 DiaryScreen 또는 WaitingScreens 표시
            final diaryResponse = viewModel.diaryResponse;
            if (diaryResponse?.myTurn == true &&
                diaryResponse!.shareGroupDetailInfo != null) {
              return DiaryView();
            } else if (diaryResponse?.myTurn == false &&
                diaryResponse?.currentWriter != null) {
              return WaitingView();
            }

            return Center(child: Text('유효하지 않은 데이터입니다.'));
          },
        ),
      ),
    );
  }
}

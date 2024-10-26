import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/screen/member/view_model/member_view_model.dart';
import 'package:project_today/ui/atoms/imgListEl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MemberView extends StatelessWidget {
  final MemberViewModel _viewModel = Get.put(MemberViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final isLoading = _viewModel.isLoading.value; // 로딩 상태 가져오기

        if (_viewModel.profilesList.isEmpty) {
          return Center(child: Text('멤버가 없습니다.'));
        }

        return ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: _viewModel.profilesList.length,
          itemBuilder: (context, index) {
            final profile = _viewModel.profilesList[index];

            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 14),
              child: Skeletonizer(
                enabled: isLoading, // 로딩 중일 때 Skeletonizer 활성화
                child: ImgListEl(
                  imgPath: profile.image,
                  title: profile.profileNickName,
                  desc: profile.role,
                  onPressed: () {
                    // 클릭했을 때 동작 정의
                    print('${profile.profileNickName} 눌림');
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

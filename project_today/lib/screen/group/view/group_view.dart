import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:project_today/screen/group/view_model/group_view_model.dart';
import 'package:project_today/ui/templates/groupTemplate.dart';

/// 내 그룹 리스트 렌더 뷰
class GroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GroupViewModel()..fetchGroups(),
      child: Scaffold(
        body: Consumer<GroupViewModel>(
          builder: (context, viewModel, child) {
            final groupData = viewModel.Groups.map((group) {
              return {
                'id': group.shareGroupId,
                'imgsrc': group.coverImage != 0
                    ? 'assets/images/cover/group_${group.coverImage}.png'
                    : 'assets/images/temp_bg.png',
                'desc': group.groupName,
              };
            }).toList();

            return Skeletonizer(
                enabled: viewModel.isLoading, // 로딩 중일 때 Skeletonizer 활성화
                child: GroupTemplate(groupData: groupData));
          },
        ),
      ),
    );
  }
}

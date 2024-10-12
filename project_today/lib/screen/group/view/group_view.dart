import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            // 로딩 상태일 때 로딩 인디케이터 표시
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            final groupData = viewModel.Groups.map((group) {
              return {
                'id': group.shareGroupId,
                'imgsrc': group.coverImage != 0
                    ? 'assets/images/cover/group_${group.coverImage}.png'
                    : 'assets/images/temp_bg.png',
                'desc': group.groupName,
              };
            }).toList();

            return GroupTemplate(groupData: groupData);
          },
        ),
      ),
    );
  }
}

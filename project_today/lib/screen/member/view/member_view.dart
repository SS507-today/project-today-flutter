import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_today/screen/member/view_model/member_view_model.dart';
import 'package:project_today/ui/atoms/defaultListEl.dart';
import 'package:project_today/ui/organisms/header.dart';

class MemberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemberViewModel()..fetchMembers(), // ViewModel 초기화
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Header(
              backgroundColor: Colors.transparent,
              title: "테스트 멤버 조회",
              showBackButton: false,
            ),
            Expanded(
              child: Consumer<MemberViewModel>(
                builder: (context, viewModel, child) {
                  // 로딩 상태 처리
                  if (viewModel.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // 데이터가 없는 경우
                  if (viewModel.members.isEmpty) {
                    return Center(
                      child: Text('멤버 정보가 없습니다.'),
                    );
                  }

                  // 멤버 리스트 표시
                  return ListView.builder(
                    itemCount: viewModel.members.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    itemBuilder: (context, index) {
                      final member = viewModel.members[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: DefaultListEl(
                          title: member.name,
                          desc: member.username,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('${member.name} clicked!')),
                            );
                          },
                          isShowArrow: false,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

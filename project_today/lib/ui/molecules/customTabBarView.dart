import 'package:flutter/material.dart';
import 'package:project_today/screen/collection/collection_screens.dart';
import 'package:project_today/screen/member/member_screens.dart';

class CustomTabBarView extends StatelessWidget {
  final TabController tabController;

  const CustomTabBarView({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        MemberScreen(),
        CollectionScreen(),
      ],
    );
  }
}

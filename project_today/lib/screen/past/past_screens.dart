import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/screen/collection/collection_screens.dart';
import 'package:project_today/screen/member/member_screens.dart';
import 'package:project_today/ui/organisms/index.dart';

class PastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        child: Column(
          children: [
            Header(
              showBackButton: true,
              title: '지난 일기장',
              showSettingsIcon: true,
            ),
            SizedBox(
              height: 211,
            ),
            Expanded(
              child: CustomTabComponent(
                tabs: [
                  Tab(text: '보관함'),
                  Tab(text: '멤버'),
                ],
                tabViews: [
                  CollectionScreen(),
                  MemberScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

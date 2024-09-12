import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/organisms/index.dart';
import 'package:project_today/screen/collection/collection_screens.dart';
import 'package:project_today/screen/member/member_screens.dart';

class Tabbartemplate extends StatelessWidget {
  /// 헤더에 들어갈 타이틀
  final String headerTitle;

  /// 이미지박스
  final String imgPath;

  const Tabbartemplate({
    super.key,
    required this.headerTitle,
    this.imgPath = 'assets/images/img_group.png',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        child: Column(
          children: [
            Header(
              showBackButton: true,
              title: headerTitle,
              showSettingsIcon: true,
            ),
            Image.asset(
              imgPath,
              width: MediaQuery.of(context).size.width,
              height: 211,
              fit: BoxFit.cover,
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

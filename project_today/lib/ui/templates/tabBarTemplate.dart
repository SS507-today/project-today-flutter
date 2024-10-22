import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/screen/collection/view/collection_view.dart';
import 'package:project_today/screen/member/view/member_view.dart';
import 'package:project_today/ui/organisms/index.dart';

class Tabbartemplate extends StatelessWidget {
  /// 헤더에 들어갈 타이틀
  final String headerTitle;

  /// 그룹 이름
  final String groupName;

  /// 그룹 설명
  final String groupDes;

  const Tabbartemplate({
    super.key,
    required this.headerTitle,
    required this.groupName,
    required this.groupDes,
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 22), // 상하 간격을 위한 padding
              child: Center(
                child: Column(
                  children: [
                    Text(
                      groupName,
                      style: FontSystem.title
                          .copyWith(color: GreyColorSystem.Grey80),
                      textAlign: TextAlign.center, // 가운데 정렬
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      groupDes,
                      style: FontSystem.body2
                          .copyWith(color: GreyColorSystem.Grey40),
                      textAlign: TextAlign.center, // 가운데 정렬
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: CustomTabComponent(
                tabs: [
                  Tab(text: '보관함'),
                  Tab(text: '멤버'),
                ],
                tabViews: [
                  CollectionView(),
                  MemberView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

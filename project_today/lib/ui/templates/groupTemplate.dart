import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/gradientFAB.dart';
import 'package:project_today/ui/organisms/header.dart';
import 'package:project_today/ui/atoms/VerticalCard.dart';

class GroupTemplate extends StatelessWidget {
  final List<Map<String, dynamic>> groupData;

  const GroupTemplate({required this.groupData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      floatingActionButton: GradientFAB(
        onPressed: () {
          Navigator.pushNamed(context, '/generate');
        },
        iconPath: 'assets/icons/ic_add.svg',
      ),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              showNotificationIcon: true,
              showSettingsIcon: true,
              barImage: 'assets/images/img_logo.png',
            ),
            Expanded(
              child: groupData.isEmpty
                  ? _buildEmptyGroupUI(context)
                  : _buildGroupGrid(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyGroupUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Text(
          '아직 그룹이 없어요\n그룹을 생성해보세요!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: GreyColorSystem.Grey80,
          ),
        ),
        SizedBox(height: 50),
        Image.asset(
          'assets/images/img_group.png',
          width: 256,
          height: 222,
        ),
      ],
    );
  }

  Widget _buildGroupGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
            child: Text(
              '내 그룹',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: GreyColorSystem.Grey90,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: groupData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75, // 카드 비율 설정
              ),
              itemBuilder: (context, index) {
                final group = groupData[index];
                return VerticalCard(
                  imgPath: group['imgsrc'] as String,
                  desc: group['desc'] as String,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/home',
                      arguments: {'id': group['id']}, // id 값을 arguments로 전달
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/gradientFAB.dart';
import 'package:project_today/ui/organisms/header.dart';
import 'package:project_today/ui/atoms/VerticalCard.dart';

/// 내 그룹 목업 데이터로 빈배열 전달 시, 조건부 렌더링 됨
const groupData = [
  {
    'id': 0,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': 'SS507',
  },
  {
    'id': 1,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹1',
  },
  {
    'id': 2,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹2',
  },
  {
    'id': 3,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹3',
  },
  {
    'id': 4,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹4',
  },
  {
    'id': 5,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹5',
  },
];

class GroupScreen extends StatelessWidget {
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
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text('This is the Group Screen'),
                  Image.asset('assets/images/img_group.png')
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/atoms.dart';
import 'package:project_today/ui/organisms/index.dart';

class ReadScreen extends StatefulWidget {
  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  // 기존 이미지 URL 또는 Uint8List 형태의 데이터를 함께 관리할 리스트
  final List<String> imageUrls = [
    'https://i.pinimg.com/564x/a1/dc/56/a1dc56e3c14ae219f3871c341bd9adaa.jpg',
    'https://i.pinimg.com/564x/2f/d7/a5/2fd7a59edc51e65dd5bdeeaf010c99c8.jpg',
    'https://i.pinimg.com/564x/39/d1/3d/39d13d34277b9ecae11dbabc01abb5cd.jpg',
  ];

  // 기존 날짜 목록
  final List<String> dates = [
    '2024년 8월 1일',
    '2024년 8월 2일',
    '2024년 8월 3일',
  ];

  // 기존 사용자 정보 목록
  final List<Map<String, String>> userInfo = [
    {
      'imgPath': 'assets/images/p1.jpg',
      'name': '시윤',
      'role': 'CLIENT',
    },
    {
      'imgPath': 'assets/images/p2.jpg',
      'name': '민수',
      'role': 'ADMIN',
    },
    {
      'imgPath': 'assets/images/p3.jpg',
      'name': '하나',
      'role': 'USER',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              showBackButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ImageCarouselWithProfile(
                  dates: dates,
                  imageUrls: imageUrls,
                  userInfo: userInfo,
                ),
              ),
            ),
            DefaultActionButton(
              text: '일기 쓰기',
              onPressed: () {
                Navigator.pushNamed(context, '/write');
              },
              isActive: true,
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/core/constant/fonts.dart';
import 'package:project_today/ui/atoms/defaultButton.dart';
import 'package:project_today/ui/organisms/header.dart';
import 'package:project_today/ui/atoms/imgListEl.dart';
import 'package:project_today/screen/write/write_screens.dart';

class WeekScreen extends StatefulWidget {
  @override
  _WeekScreenState createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'id': 0,
      'date': '2024년 8월 3일',
      'image': 'assets/images/d1.jpeg',
      'authorInfo': {
        'name': '시윤',
        'desc': '하루종일 개발 중.. 도파민이 필요해',
        'profileImage': 'assets/images/p1.png',
      },
    },
    {
      'id': 1,
      'date': '2024년 8월 5일',
      'image': 'assets/images/d2.jpeg',
      'authorInfo': {
        'name': '혜령',
        'desc': '나는 연애중 ><',
        'profileImage': 'assets/images/p3.png',
      },
    },
    {
      'id': 2,
      'date': '2024년 8월 6일',
      'image': 'assets/images/d3.jpeg',
      'authorInfo': {
        'name': '민진',
        'desc': '오늘은 무슨 웹툰볼까 킼킼',
        'profileImage': 'assets/images/p4.png',
      },
    },
    {
      'id': 3,
      'date': '2024년 8월 8일',
      'image': 'assets/images/d4.png',
      'authorInfo': {
        'name': '수연',
        'desc': '내 최애 음식은 짜장면',
        'profileImage': 'assets/images/p5.png',
      },
    },
  ];

  int _currentIndex = 0;

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
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      items[_currentIndex]['date'],
                      textAlign: TextAlign.center,
                      style: FontSystem.title
                          .copyWith(color: GreyColorSystem.Grey90),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: SizedBox(
                        height: 500,
                        child: PageView.builder(
                          itemCount: items.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      item['image'],
                                      width: 243,
                                      height: 324,
                                      fit: BoxFit.cover,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        List.generate(items.length, (index) {
                                      return AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        width: 8.0,
                                        height: 8.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _currentIndex == index
                                              ? GreyColorSystem.Grey70
                                              : GreyColorSystem.Grey20,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                ImgListEl(
                                  imgPath: item['authorInfo']['profileImage'],
                                  title: item['authorInfo']['name'],
                                  desc: item['authorInfo']['desc'],
                                  onPressed: () {
                                    print('${item['authorInfo']['name']} 클릭됨');
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_currentIndex == items.length - 1)
              Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                child: DefaultActionButton(
                  text: '일기 쓰기',
                  onPressed: () async {
                    final Uint8List? newImageData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WriteScreen(),
                      ),
                    );
                    setState(() {
                      if (items.isNotEmpty) {
                        items.removeLast();
                      }
                      items.add({
                        'id': items.length,
                        'date': '2024년 8월 8일',
                        'image': 'assets/images/d5.png', // TODO 반환된 이미지 추가
                        'authorInfo': {
                          'name': '수연',
                          'desc': '내 최애 음식은 짜장면',
                          'profileImage': 'assets/images/p5.png',
                        },
                      });
                    });
                  },
                  isActive: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

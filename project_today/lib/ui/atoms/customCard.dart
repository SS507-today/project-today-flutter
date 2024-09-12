import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';

class CustomCard extends StatelessWidget {
  ///박스 가로 길이
  final double width;

  ///박스 세로 길이
  final double height;

  ///배경 이미지
  final String backgroundImage;

  ///일기 시작 날짜
  final String startDate;

  ///일기 종료 날짜
  final String endDate;

  ///탭 했을 때 실행 될 콜백 함수 (null 일 시 아무것도 실행 X)
  final VoidCallback? onTap;

  // 생성자를 통해 필요한 파라미터를 받음
  const CustomCard({
    Key? key,
    this.width = 169,
    this.height = 225,
    required this.backgroundImage,
    required this.startDate,
    required this.endDate,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      startDate,
                      style: FontSystem.buttonLight
                          .copyWith(color: GreyColorSystem.Grey70),
                    ),
                    Text(
                      '- $endDate',
                      style: FontSystem.buttonLight
                          .copyWith(color: GreyColorSystem.Grey70),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

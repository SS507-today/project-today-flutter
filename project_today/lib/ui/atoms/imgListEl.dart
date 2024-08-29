import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';

class ImgListEl extends StatelessWidget {
  /// 요소 원형 이미지 경로
  final String imgPath;

  /// 요소 메인 텍스트
  final String title;

  /// 요소 설명 텍스트
  final String desc;

  /// 버튼이 눌렸을 때 실행될 콜백 함수
  final VoidCallback onPressed;

  const ImgListEl({
    super.key,
    required this.imgPath,
    required this.title,
    required this.desc,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 18.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Row(
          children: [
            Container(
              width: 63.0,
              height: 63.0,
              margin: const EdgeInsets.only(right: 19.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: GreyColorSystem.Grey80,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: GreyColorSystem.Grey50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

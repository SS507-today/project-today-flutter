import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';

class VerticalCard extends StatelessWidget {
  /// 배경 이미지 경로
  final String imgPath;

  /// 요소 설명 텍스트
  final String desc;

  /// 버튼이 눌렸을 때 실행될 콜백 함수
  final VoidCallback onPressed;

  const VerticalCard({
    super.key,
    required this.imgPath,
    required this.desc,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 169.0,
        height: 225.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Stack(
          children: [
            Container(
              width: 169.0,
              height: 225.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 67.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.63),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(14.0),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: GreyColorSystem.Grey70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

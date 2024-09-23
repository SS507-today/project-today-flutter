import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/organisms/index.dart';

class GradientHeader extends StatelessWidget {
  /// 페이지네이션을 위한 현재 페이지 인덱스
  final int currentPage;

  /// 헤더 텍스트
  final String text;

  /// 헤더 컬러 타입 (Pink | Orange) //TODO: enum으로 리팩토링
  final String colorType;

  const GradientHeader({
    required this.currentPage,
    required this.text,
    required this.colorType,
  });

  @override
  Widget build(BuildContext context) {
    final colors = (colorType == 'Pink')
        ? [
            PinkColorSystem.Pink,
            PinkColorSystem.Pink30,
            PinkColorSystem.Pink10,
            Colors.white
          ]
        : [
            OrangeColorSystem.Orange,
            OrangeColorSystem.Orange30,
            OrangeColorSystem.Orange10,
            Colors.white
          ];

    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors[2].withOpacity(1.0),
            colors[2].withOpacity(0.7),
            colors[3].withOpacity(1.0),
          ],
          stops: [0.0, 0.8, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            backgroundColor: Colors.transparent,
            showBackButton: true,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == currentPage ? colors[0] : colors[1],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: colors[0],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

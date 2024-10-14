import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:project_today/core/constant/index.dart';

class GlowGradientImageBox extends StatelessWidget {
  final String imgPath; // 이미지 경로
  final double width; // 이미지 너비
  final double height; // 이미지 높이
  final VoidCallback? onTap; // 탭 이벤트

  const GlowGradientImageBox({
    Key? key,
    required this.imgPath,
    this.width = 231,
    this.height = 307,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      startDelay: const Duration(milliseconds: 0),
      glowColor: PinkColorSystem.Pink30,
      duration: const Duration(milliseconds: 2000),
      repeat: true,
      glowShape: BoxShape.circle,
      curve: Curves.fastOutSlowIn,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            image: DecorationImage(
              image: AssetImage(imgPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

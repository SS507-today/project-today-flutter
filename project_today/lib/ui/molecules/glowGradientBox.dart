import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/atoms/atoms.dart';

class GlowGradientBox extends StatelessWidget {
  final VoidCallback? onTap; // onTap을 nullable로 설정

  const GlowGradientBox({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      startDelay: const Duration(milliseconds: 1000),
      glowColor: PinkColorSystem.Pink30,
      glowShape: BoxShape.circle,
      curve: Curves.fastOutSlowIn,
      child: CustomMeshGradientBox(
        onTap: onTap, // 전달된 콜백 사용
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/ui/atoms/atoms.dart';
import 'package:project_today/ui/molecules/index.dart';

class ProfileData {
  final String imgPath;
  final String title;
  final String desc;
  final VoidCallback? onPressed;

  ProfileData({
    required this.imgPath,
    required this.title,
    required this.desc,
    this.onPressed,
  });
}

class TitleCardRule extends StatelessWidget {
  /// 이름
  final String name;

  /// 이름 옆 텍스트
  final String topText;

  /// 아래 텍스트
  final String bottomText;

  /// 타이머가 종료되는 시간 (DateTime)
  final DateTime? createdAt;

  /// 그레디언트 박스
  final bool showGradientBox;
  final bool showGlowGradientBox;
  final bool showGlowGradientImageBox;

  ///그레디언트 박스 탭 했을 때 실행 될 콜백 함수 (null 일 시 아무것도 실행 X)
  final VoidCallback? onTapGradientBox;

  /// 이미지박스
  final String? imgPath;

  // 이미지박스 너비
  final int? imgWidth;

  /// 규칙
  final List<Map<String, String?>>? rules;

  /// 프로필 데이터
  final ProfileData? profileData;

  const TitleCardRule({
    super.key,
    this.name = "",
    this.topText = "",
    this.bottomText = "",
    this.createdAt,
    this.showGradientBox = false,
    this.showGlowGradientBox = false,
    this.showGlowGradientImageBox = false,
    this.onTapGradientBox,
    this.imgPath,
    this.imgWidth,
    this.rules,
    this.profileData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomNameText(
          name: name,
          topText: topText,
          bottomText: bottomText,
          createdAt: createdAt,
        ),
        SizedBox(height: 40),
        if (imgPath != null && showGlowGradientImageBox)
          GlowGradientImageBox(
            imgPath: imgPath!, // 이미지 경로 전달
            width: imgWidth?.toDouble() ?? double.infinity,
            onTap: onTapGradientBox, // 탭 이벤트 전달
            height: 305.0,
          ),
        if (imgPath != null && !showGlowGradientImageBox)
          Container(
            width: imgWidth?.toDouble() ??
                double.infinity, // imgWidth가 있으면 해당 값, 없으면 전체 너비
            height: 305.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              image: DecorationImage(
                image: AssetImage(imgPath!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(height: 30),
        if (showGradientBox)
          CustomMeshGradientBox(
            onTap: onTapGradientBox,
          ),
        if (showGlowGradientBox)
          GlowGradientBox(
            onTap: onTapGradientBox,
          ),
        if (rules != null) RuleCardList(rules: rules!),
        if (profileData != null)
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: ImgListEl(
              imgPath: profileData!.imgPath,
              title: profileData!.title,
              desc: profileData!.desc,
              onPressed: profileData!.onPressed ?? () {},
            ),
          ),
      ],
    );
  }
}

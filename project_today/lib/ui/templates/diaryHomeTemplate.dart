import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/index.dart';
import 'package:project_today/ui/organisms/index.dart';

class Diaryhometemplate extends StatelessWidget {
  /// 헤더에 들어갈 타이틀
  final String headerTitle;

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

  ///그레디언트 박스 탭 했을 때 실행 될 콜백 함수 (null 일 시 아무것도 실행 X)
  final VoidCallback? onTapGradientBox;

  /// 이미지박스
  final String? imgPath;

  /// 규칙
  final List<Map<String, String?>>? rules;

  /// 프로필 데이터
  final ProfileData? profileData;

  /// 버튼 텍스트
  final String buttonText;

  /// 버튼이 눌렸을 때 실행될 콜백 함수
  final VoidCallback onPressed;

  /// 버튼이 활성화된 상태인지 여부
  final bool isActive;

  const Diaryhometemplate({
    super.key,
    required this.headerTitle,
    this.name = "",
    this.topText = "",
    this.bottomText = "",
    this.createdAt,
    this.showGradientBox = false,
    this.showGlowGradientBox = false,
    this.onTapGradientBox,
    this.imgPath,
    this.rules,
    this.profileData,
    this.buttonText = "지난 일기장",
    required this.onPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        child: Column(
          children: [
            Header(
              showBackButton: true,
              title: headerTitle,
              showSettingsIcon: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 30),
                child: TitleCardRule(
                  name: name,
                  topText: topText,
                  bottomText: bottomText,
                  createdAt: createdAt,
                  showGradientBox: showGradientBox,
                  showGlowGradientBox: showGlowGradientBox,
                  onTapGradientBox: onTapGradientBox,
                  imgPath: imgPath,
                  rules: rules,
                  profileData: profileData,
                ),
              ),
            ),
            DefaultActionButton(
              text: buttonText,
              onPressed: onPressed,
              isActive: isActive,
            ) // 상태에 따른 액션 버튼을 표시
          ],
        ),
      ),
    );
  }
}

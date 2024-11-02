import 'package:flutter/material.dart';
import 'dart:io'; // File을 다루기 위해 필요
import 'package:flutter_svg/svg.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/organisms/header.dart';
import 'package:project_today/ui/atoms/index.dart';
import 'package:image_picker/image_picker.dart';

class SettingTemplate extends StatelessWidget {
  final String? image;
  final VoidCallback onChangeNickname;
  final VoidCallback? onLogout; // 로그아웃 콜백 함수도 선택적으로 받음
  final String nickname;

  // 새로운 콜백 함수 추가
  final VoidCallback? onFirstOption;
  final String? desc;
  final VoidCallback? onSecondOption;
  final VoidCallback? onThirdOption;

  // isGroupSetting 기본값 true
  final bool isGroupSetting;

  const SettingTemplate({
    required this.image,
    required this.onChangeNickname,
    this.onLogout, // 선택적 로그아웃 콜백
    required this.nickname,
    this.onFirstOption,
    this.desc,
    this.onSecondOption,
    this.onThirdOption,
    this.isGroupSetting = true, // 기본값 설정
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              backgroundColor: Colors.transparent,
              title: "설정",
              showBackButton: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 23, bottom: 33),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: image != null && image!.isNotEmpty
                              ? NetworkImage(image!)
                              : AssetImage('assets/images/empty.png')
                                  as ImageProvider,
                          backgroundColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  DefaultListEl(
                    title: '닉네임',
                    desc: nickname,
                    onPressed: onChangeNickname,
                    isShowArrow: true,
                  ),
                  SizedBox(height: 14),

                  // isGroupSetting이 false일 경우 로그아웃 버튼과 콜백 표시
                  if (!isGroupSetting) ...[
                    DefaultListEl(
                      title: '로그아웃',
                      onPressed: onLogout ?? () {},
                      isShowArrow: false,
                    ),
                    SizedBox(height: 14),
                    if (!isGroupSetting)
                      DefaultListEl(
                        title: '회원 탈퇴',
                        titleColor: ColorSystem.Red,
                        onPressed: onThirdOption ?? () {},
                        isShowArrow: true,
                      ),
                  ],

                  // isGroupSetting이 true일 경우 추가된 항목 표시
                  if (isGroupSetting) ...[
                    DefaultListEl(
                      title: '소개',
                      onPressed: onFirstOption ?? () {},
                      desc: desc,
                      isShowArrow: true,
                    ),
                    SizedBox(height: 14),
                    DefaultListEl(
                      title: '그룹 설정 변경',
                      onPressed: onSecondOption ?? () {},
                      isShowArrow: true,
                    ),
                    SizedBox(height: 14),
                    DefaultListEl(
                      title: '그룹 탈퇴',
                      titleColor: ColorSystem.Red,
                      onPressed: onThirdOption ?? () {},
                      isShowArrow: true,
                    ),
                    SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

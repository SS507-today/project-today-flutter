import 'package:flutter/material.dart';
import 'dart:io'; // File을 다루기 위해 필요
import 'package:flutter_svg/svg.dart';
import 'package:project_today/ui/organisms/header.dart';
import 'package:project_today/ui/atoms/atoms.dart';
import 'package:image_picker/image_picker.dart';

class SettingTemplate extends StatelessWidget {
  final String? image;
  // final VoidCallback onImagePick;
  final VoidCallback onChangeNickname;
  final VoidCallback onLogout;
  final String nickname;

  const SettingTemplate({
    required this.image,
    //  required this.onImagePick,
    required this.onChangeNickname,
    required this.onLogout,
    required this.nickname,
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
                              ? NetworkImage(
                                  image!) // image가 null이 아니고 비어있지 않다면 NetworkImage 사용
                              : AssetImage('assets/images/i1.png')
                                  as ImageProvider, // 그렇지 않다면 기본 이미지 사용
                          backgroundColor: Colors.grey[300],
                        ),
                        /*  Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: onImagePick,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                'assets/icons/ic_cam.svg',
                                width: 34.0,
                                height: 34.0,
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  DefaultListEl(
                    title: '닉네임 변경',
                    desc: nickname,
                    onPressed: onChangeNickname,
                    isShowArrow: true,
                  ),
                  SizedBox(height: 14),
                  DefaultListEl(
                    title: '로그아웃',
                    onPressed: onLogout,
                    isShowArrow: false,
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

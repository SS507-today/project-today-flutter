import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/atoms/atoms.dart';
import 'package:project_today/ui/molecules/index.dart';
import 'package:project_today/ui/organisms/index.dart';

class Checktemplate extends StatelessWidget {
  ///이미지 데이터
  final Uint8List imageData;

  /// 멤버들의 정보가 담긴 리스트 (최대 5명)
  final List<Map<String, String>> members;

  ///완료 버튼 클릭시
  final VoidCallback? onCompleteIconPressed;

  const Checktemplate({
    super.key,
    required this.imageData,
    required this.members,
    this.onCompleteIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              showBackButton: true,
              showCompleteIcon: true,
              onCompleteIconPressed: () {
                onCompleteIconPressed?.call();
                Navigator.of(context).pop({});
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        imageData,
                        width: 353,
                        height: 470,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
              child: DefaultActionButton(
                text: '태그하기',
                onPressed: () {
                  showTagBottomSheet(context, members);
                },
                isActive: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

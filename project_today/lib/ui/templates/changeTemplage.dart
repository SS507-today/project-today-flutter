import 'package:flutter/material.dart';
import 'package:project_today/ui/organisms/header.dart';
import 'package:project_today/ui/atoms/atoms.dart';

class ChangeTemplate extends StatelessWidget {
  final bool isButtonActive;
  final ValueChanged<String> onNicknameChanged;
  final VoidCallback onNextPressed;

  const ChangeTemplate({
    required this.isButtonActive,
    required this.onNicknameChanged,
    required this.onNextPressed,
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
              title: "닉네임 변경",
              showBackButton: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 29, left: 20, right: 20),
              child: CustomTextField(
                hintText: "2 ~ 8자 이내로 입력해 주세요",
                onChanged: onNicknameChanged,
              ),
            ),
            const Spacer(),
            DefaultActionButton(
              text: "완료",
              isActive: isButtonActive,
              onPressed: onNextPressed,
            ),
          ],
        ),
      ),
    );
  }
}

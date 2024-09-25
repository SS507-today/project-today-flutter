import 'package:flutter/material.dart';
import 'package:project_today/ui/atoms/atoms.dart';
import 'package:project_today/ui/organisms/index.dart';

class GenerateTemplate extends StatelessWidget {
  final int currentPage;
  final String headerText;
  final String colorType;
  final List<Widget> pages;
  final bool isButtonActive;
  final VoidCallback onNextPressed;

  const GenerateTemplate({
    required this.currentPage,
    required this.headerText,
    required this.colorType,
    required this.pages,
    required this.isButtonActive,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            GradientHeader(
              currentPage: currentPage,
              text: headerText,
              colorType: colorType,
            ),
            Expanded(
              child: pages[currentPage],
            ),
            DefaultActionButton(
              text: currentPage == 3 ? "그룹 생성 완료" : "다음",
              isActive: isButtonActive,
              onPressed: onNextPressed,
            ),
          ],
        ),
      ),
    );
  }
}

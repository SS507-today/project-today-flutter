import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/core/constant/fonts.dart';
import 'package:project_today/ui/atoms/defaultButton.dart';
import 'package:project_today/ui/organisms/header.dart';

class WeekScreen extends StatelessWidget {
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
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      '2024년 8월 1일',
                      textAlign: TextAlign.center,
                      style: FontSystem.title
                          .copyWith(color: GreyColorSystem.Grey90),
                    ),
                    SizedBox(
                      height: 38.0,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                child: DefaultActionButton(
                  text: '일기 쓰기',
                  onPressed: () {
                    Navigator.pushNamed(context, '/write');
                  },
                  isActive: true,
                )),
          ],
        ),
      ),
    );
  }
}

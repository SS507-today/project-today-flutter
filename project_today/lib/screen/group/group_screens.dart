import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/index.dart';
import 'package:project_today/ui/molecules/index.dart';
import 'package:project_today/ui/organisms/header.dart';

class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      floatingActionButton: GradientFAB(
        onPressed: () {
          Navigator.pushNamed(context, '/generate');
        },
        iconPath: 'assets/icons/ic_add.svg',
      ),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              showNotificationIcon: true,
              showSettingsIcon: true,
              barImage: 'assets/images/img_logo.png',
            ),
            Expanded(
                // Expanded는 남은 공간을 차지하는 데 사용
                child: SingleChildScrollView(
              child: CustomImageCarousel(
                imageUrls: [
                  'https://i.pinimg.com/564x/a1/dc/56/a1dc56e3c14ae219f3871c341bd9adaa.jpg',
                  'https://i.pinimg.com/564x/2f/d7/a5/2fd7a59edc51e65dd5bdeeaf010c99c8.jpg',
                  'https://i.pinimg.com/564x/39/d1/3d/39d13d34277b9ecae11dbabc01abb5cd.jpg',
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

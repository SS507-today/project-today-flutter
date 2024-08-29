import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/gradientFAB.dart';
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
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text('This is the Group Screen'),
                  Image.asset('assets/images/img_group.png')
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

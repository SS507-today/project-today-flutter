import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/organisms/header.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              backgroundColor: Colors.transparent,
              title: "설정",
              showBackButton: true,
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text('This is setting screen'),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

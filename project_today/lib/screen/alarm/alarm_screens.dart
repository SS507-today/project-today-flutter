import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/organisms/header.dart';

class AlarmScreen extends StatelessWidget {
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
              title: "알림",
              showBackButton: true,
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text('This is alarm screen'),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

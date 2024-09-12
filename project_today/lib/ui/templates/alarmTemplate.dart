import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/organisms/index.dart';
import 'package:project_today/ui/molecules/index.dart';

class alarmTemplate extends StatelessWidget {
  final List<Map<String, dynamic>> notiData;

  alarmTemplate({required this.notiData});

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
            //TODO : 아래 두 요소를 하나로 묶고 전체 horizontal 패딩 주기
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 20, left: 20, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete, color: ColorSystem.Red, size: 16),
                  Text(
                    "일괄 삭제",
                    style: TextStyle(color: ColorSystem.Red, fontSize: 15),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: NotiList(notiData: notiData),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

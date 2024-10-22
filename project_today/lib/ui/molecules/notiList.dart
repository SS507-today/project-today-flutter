import 'package:flutter/material.dart';
import 'package:project_today/ui/atoms/index.dart';

class NotiList extends StatelessWidget {
  final List<Map<String, dynamic>> notiData;

  const NotiList({super.key, required this.notiData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < notiData.length; i++) ...[
          NotiListEl(
            content: notiData[i]['content'],
            desc: notiData[i]['desc'],
            type: notiData[i]['type'],
            onPressed: () {
              print('${notiData[i]['content']} 알림 클릭 >> 라우팅');
            },
            isChecked: notiData[i]['isChecked'],
          ),
          // 마지막 알림 요소 빼고 적용
          if (i < notiData.length - 1) SizedBox(height: 14),
        ]
      ],
    );
  }
}

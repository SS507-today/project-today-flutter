import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/alarmTemplate.dart';
import 'package:project_today/ui/atoms/notiListEl.dart';

const notiData = [
  {
    'id': 0,
    'type': NotiType.DEFAULT,
    'content': '시경님이 콕 찔렀어요!\n오늘의 일기를 작성해보세요',
    'desc': 'SS507',
    'isChecked': false,
  },
  {
    'id': 1,
    'type': NotiType.DEFAULT,
    'content': '친구들의 오늘을 담은 새로운 일기가\n도착했어요! 얼른 확인해보세요',
    'desc': 'SS507',
    'isChecked': false,
  },
  {
    'id': 2,
    'type': NotiType.DEFAULT,
    'content': '오늘은 일기장에 민진님이 들어왔어요!',
    'desc': 'SS507',
    'isChecked': true,
  },
];

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return alarmTemplate(notiData: notiData);
  }
}

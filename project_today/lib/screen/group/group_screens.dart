import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/groupTemplate.dart';

/// 내 그룹 목업 데이터로 빈배열 전달 시, 조건부 렌더링 됨
const groupData = [
  {
    'id': 0,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': 'SS507',
  },
  {
    'id': 1,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹1',
  },
  {
    'id': 2,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹2',
  },
  {
    'id': 3,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹3',
  },
  {
    'id': 4,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹4',
  },
  {
    'id': 5,
    'imgsrc': 'assets/images/temp_bg.png',
    'desc': '그룹5',
  },
];

class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GroupTemplate(groupData: groupData);
  }
}

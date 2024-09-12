import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/checkTemplate.dart';

List<Map<String, String>> members = [
  {'name': '수연', 'imgPath': 'assets/images/p1.jpg'},
  {'name': '민진', 'imgPath': 'assets/images/p2.jpg'},
  {'name': '시윤', 'imgPath': 'assets/images/p3.jpg'},
  {'name': '혜령', 'imgPath': 'assets/images/p1.jpg'},
];

class CheckScreen extends StatelessWidget {
  final Uint8List imageData;

  const CheckScreen({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checktemplate(
      imageData: imageData,
      onCompleteIconPressed: () {
        //TO DO: 서버에 사진, 태그한 사람 등 전송
      },
      members: members,
    );
  }
}

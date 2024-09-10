import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/atoms/index.dart';
import 'package:project_today/ui/organisms/index.dart';
import 'package:project_today/ui/templates/diaryHomeTemplate.dart';

// 상태를 나타내는 enum 정의
enum ScreenState {
  BEFORE_START,
  NOT_MY_TURN,
  MY_TURN,
}

class DiaryScreen extends StatefulWidget {
  // ScreenState를 파라미터로 받음
  final ScreenState initialScreenState;

  const DiaryScreen({
    Key? key,
    required this.initialScreenState,
  }) : super(key: key);

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late ScreenState _screenState;

  @override
  void initState() {
    super.initState();
    // 위젯 생성 시 초기 상태를 설정
    _screenState = widget.initialScreenState;
  }

  final List<Map<String, String?>> rules = [
    {'title': '규칙 1', 'content': '까먹지 않고 꼭 쓰기'},
    {'title': '규칙 2', 'content': '남의 험담은 하지 않기'},
    {'title': '규칙 3', 'content': '성의있게 쓰기~!'},
  ];

  // 상태에 따른 화면 전환
  Widget _buildScreenContent() {
    switch (_screenState) {
      case ScreenState.MY_TURN:
        return Diaryhometemplate(
          headerTitle: 'SS507',
          topText: "새로운 일기를 담은\n교환일기가 도착했어요!",
          showGlowGradientBox: true,
          rules: rules,
          buttonText: "초대 수락하기",
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/diary');
          },
        );

      case ScreenState.BEFORE_START:
        return Diaryhometemplate(
            headerTitle: 'SS507',
            topText: "친구들이 모두 들어오면\n교환일기가 시작돼요!",
            createdAt: DateTime.now().add(Duration(minutes: 2)),
            imgPath: 'assets/images/img_group.png',
            isActive: false,
            onPressed: () {});

      case ScreenState.NOT_MY_TURN:
        return Diaryhometemplate(
            headerTitle: 'SS507',
            name: "혜령",
            topText: "님이 일기를 쓰고 있어요",
            bottomText: "눌러서 재촉해보세요!",
            imgPath: 'assets/images/img_group.png',
            onPressed: () {});

      default:
        return Container();
    }
  }

  // 상태 변경 함수 (FAB 등에서 사용 가능)
  void _changeScreenState(ScreenState newState) {
    setState(() {
      _screenState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreenContent(),
    );
  }
}

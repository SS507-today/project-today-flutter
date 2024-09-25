import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/changeTemplage.dart';

class ChangeScreen extends StatefulWidget {
  @override
  _ChangeScreenState createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  bool isButtonActive = false;

  void _onNicknameChanged(String value) {
    setState(() {
      isButtonActive = value.length >= 2 && value.length <= 8;
    });
  }

  void _onNextPressed() {
    if (isButtonActive) {
      Navigator.pushNamed(context, '/setting');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeTemplate(
      isButtonActive: isButtonActive,
      onNicknameChanged: _onNicknameChanged,
      onNextPressed: _onNextPressed,
    );
  }
}

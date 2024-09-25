import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // ImagePicker 임포트
import 'dart:io'; // File을 다루기 위해 필요
import 'package:project_today/ui/templates/settingTemplate.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  XFile? _image;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  void _onChangeNickname() {
    Navigator.pushNamed(context, '/change');
  }

  void _onLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("로그아웃 되었습니다"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingTemplate(
      image: _image,
      onImagePick: _pickImage,
      onChangeNickname: _onChangeNickname,
      onLogout: _onLogout,
      nickname: '시경',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/organisms/index.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:image_picker/image_picker.dart'; // ImagePicker 임포트
import 'dart:io'; // File을 다루기 위해 필요
import 'package:project_today/ui/atoms/atoms.dart';
import 'package:flutter_svg/svg.dart';

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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 23, bottom: 33),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _image != null
                              ? FileImage(File(_image!.path))
                              : AssetImage('assets/images/i1.png')
                                  as ImageProvider,
                          backgroundColor: Colors.grey[300],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                'assets/icons/ic_cam.svg',
                                width: 34.0,
                                height: 34.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DefaultListEl(
                    title: '닉네임 변경',
                    desc: '시경',
                    onPressed: () {
                      Navigator.pushNamed(context, '/change');
                    },
                    isShowArrow: true,
                  ),
                  SizedBox(height: 14),
                  DefaultListEl(
                    title: '로그아웃',
                    onPressed: () {
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
                    },
                    isShowArrow: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

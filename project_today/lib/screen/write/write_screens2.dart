import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/defaultButton.dart';
import 'package:project_today/ui/organisms/header.dart';

class WriteScreen2 extends StatelessWidget {
  final Uint8List imageData;

  const WriteScreen2({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              showBackButton: true,
              showCompleteIcon: true,
              onCompleteIconPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FutureBuilder<void>(
                      future: _loadImage(), // Simulate image loading
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error loading image'));
                        } else {
                          return Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                imageData,
                                width: 353,
                                height: 470,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                child: DefaultActionButton(
                  text: '태그하기',
                  onPressed: () {},
                  isActive: true,
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _loadImage() async {
    await Future.delayed(
        Duration(milliseconds: 500)); // Simulate a delay for loading
  }
}

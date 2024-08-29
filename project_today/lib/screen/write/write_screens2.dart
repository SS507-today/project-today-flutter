import 'dart:typed_data';
import 'package:flutter/material.dart';

class WriteScreen2 extends StatelessWidget {
  final Uint8List imageData;

  const WriteScreen2({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _loadImage(), // Simulate image loading
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading image'));
          } else {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  imageData,
                  width: 104,
                  height: 104,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _loadImage() async {
    await Future.delayed(
        Duration(milliseconds: 500)); // Simulate a delay for loading
  }
}

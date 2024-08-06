import 'package:flutter/material.dart';
import 'package:project_today/screen/test/test_screens.dart';

class DiaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diary"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TestScreen()),
            );
          },
          child: Text('go to test'),
        ),
      ),
    );
  }
}

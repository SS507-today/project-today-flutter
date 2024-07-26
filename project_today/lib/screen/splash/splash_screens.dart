import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveScreen() {
    Navigator.pushReplacementNamed(context, '/index');
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 3000), () {
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is the Splash Screen'),
      ),
    );
  }
}

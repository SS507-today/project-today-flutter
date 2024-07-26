import 'package:flutter/material.dart';
import 'package:project_today/screen/screens_group.dart';
import 'package:project_today/screen/screens_diary.dart';
import 'package:project_today/screen/screens_onboard.dart';
import 'package:project_today/screen/screens_index.dart';
import 'package:project_today/screen/screens_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오늘은',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => SplashScreen(),
        '/index': (context) => IndexScreen(),
        '/group': (context) => GroupScreen(),
        '/onboard': (context) => OnboardScreen(),
        '/diary': (context) => DiaryScreen(),
      },
      initialRoute: '/',
    );
  }
}

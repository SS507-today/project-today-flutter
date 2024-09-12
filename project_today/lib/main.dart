import 'package:flutter/material.dart';
import 'package:project_today/screen/alarm/alarm_screens.dart';
import 'package:project_today/screen/diary/timer_screens.dart';
import 'package:project_today/screen/diary/waiting_screens.dart';
import 'package:project_today/screen/generate/generate_screens.dart';
import 'package:project_today/screen/group/group_screens.dart';
import 'package:project_today/screen/diary/diary_screens.dart';
import 'package:project_today/screen/invite/invite_screens.dart';
import 'package:project_today/screen/onboard/onboard_screens.dart';
import 'package:project_today/screen/past/past_screens.dart';
import 'package:project_today/screen/read/read_screens.dart';
import 'package:project_today/screen/screens_index.dart';
import 'package:project_today/screen/setting/setting_screens.dart';
import 'package:project_today/screen/splash/splash_screens.dart';
import 'package:project_today/screen/write/write_screens.dart';

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
        '/alarm': (context) => AlarmScreen(),
        '/setting': (context) => SettingScreen(),
        '/generate': (context) => GenerateScreen(),
        '/past': (context) => PastScreen(),
        '/read': (context) => ReadScreen(),
        '/invite': (context) => InviteScreen(),
        '/timer': (context) => TimerScreen(),
        '/waiting': (context) => WaitingScreens(),
        '/write': (context) => WriteScreen(),
      },
      initialRoute: '/',
    );
  }
}

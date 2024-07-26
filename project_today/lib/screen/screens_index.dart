import 'package:project_today/src/colors.dart';
import 'package:flutter/material.dart';

import 'package:project_today/screen/screens_group.dart';
import 'package:project_today/screen/screens_diary.dart';
import 'package:project_today/screen/screens_onboard.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          GroupScreen(),
          DiaryScreen(),
          OnboardScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '그룹',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '다이어리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '온보딩',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorSystem.Red,
        onTap: _onItemTapped,
      ),
    );
  }
}

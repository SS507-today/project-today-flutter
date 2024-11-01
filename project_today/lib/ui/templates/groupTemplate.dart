import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/molecules/gradientFabMenu.dart';
import 'package:project_today/ui/organisms/header.dart';
import 'package:project_today/ui/atoms/VerticalCard.dart';

class GroupTemplate extends StatefulWidget {
  final List<Map<String, dynamic>> groupData;

  const GroupTemplate({
    required this.groupData,
  });

  @override
  _GroupTemplateState createState() => _GroupTemplateState();
}

class _GroupTemplateState extends State<GroupTemplate> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'label': '그룹 생성하기',
        'font-color': PinkColorSystem.Pink,
        'bg-color': PinkColorSystem.Pink10,
        'route': '/generate',
        'animationOffset': 2,
      },
      {
        'label': '그룹 참가하기',
        'font-color': OrangeColorSystem.Orange,
        'bg-color': OrangeColorSystem.Orange10,
        'route': '/participate',
        'animationOffset': 1,
      },
    ];

    return Scaffold(
      floatingActionButton: GradientFabMenu(menuItems: menuItems),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              backgroundColor: Colors.white,
              showNotificationIcon: true,
              showSettingsIcon: true,
              onSettingsIconPressed: () {
                Navigator.pushNamed(context, '/setting');
              },
              barImage: 'assets/icons/header_logo.svg',
            ),
            Expanded(
              child: widget.groupData.isEmpty
                  ? _buildEmptyGroupUI(context)
                  : _buildGroupGrid(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyGroupUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Text(
          '아직 그룹이 없어요\n그룹을 생성해보세요!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: GreyColorSystem.Grey80,
          ),
        ),
        SizedBox(height: 50),
        Image.asset(
          'assets/images/no-group.png',
          width: double.infinity,
          height: 244,
        ),
      ],
    );
  }

  Widget _buildGroupGrid(BuildContext context) {
    return Container(
      color: GreyColorSystem.Grey3,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: widget.groupData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.751, // 카드 비율 설정
              ),
              itemBuilder: (context, index) {
                final group = widget.groupData[index];
                return VerticalCard(
                  imgPath: group['imgsrc'] as String,
                  desc: group['desc'] as String,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/home',
                      arguments: {'id': group['id']}, // id 값을 arguments로 전달
                    );
                  },
                  isLoading: isLoading,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/ui/atoms/gradientFAB.dart';

class GradientFabMenu extends StatefulWidget {
  final List<Map<String, dynamic>> menuItems;

  const GradientFabMenu({Key? key, required this.menuItems}) : super(key: key);

  @override
  _GradientFabMenuState createState() => _GradientFabMenuState();
}

class _GradientFabMenuState extends State<GradientFabMenu>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false; // 메뉴 열림/닫힘 상태 관리
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      if (_isMenuOpen) {
        _controller.reverse(); // 메뉴 닫힘 애니메이션
      } else {
        _controller.forward(); // 메뉴 열림 애니메이션
      }
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // 메뉴 항목들 (메뉴가 열릴 때만 표시)
        if (_isMenuOpen)
          ...widget.menuItems.map((item) {
            return _buildMenuButton(
              label: item['label'] as String,
              bgColor: item['bg-color'] as Color, // bgColor 수정
              fontColor: item['font-color'] as Color, // fontColor 수정
              route: item['route'] as String,
              animationOffset: item['animationOffset'] as int,
              context: context,
            );
          }).toList(),

        // GradientFAB을 사용하여 메뉴 열고 닫기
        GradientFAB(
          onPressed: _toggleMenu, // 메뉴 열고 닫는 동작
          iconPath: _isMenuOpen
              ? 'assets/icons/ic_close.svg'
              : 'assets/icons/ic_add.svg', // 열릴 때는 X 아이콘, 닫힐 때는 + 아이콘
        ),
      ],
    );
  }

  Widget _buildMenuButton({
    required String label,
    required Color bgColor,
    required Color fontColor,
    required String route,
    required int animationOffset,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: animationOffset * 70.0),
      child: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          label: Text(
            label,
            style: TextStyle(color: fontColor, fontSize: 16),
          ),
          backgroundColor: bgColor,
        ),
      ),
    );
  }
}

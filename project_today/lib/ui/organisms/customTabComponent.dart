import 'package:flutter/material.dart';
import 'package:project_today/ui/molecules/index.dart';

class CustomTabComponent extends StatefulWidget {
  /// 탭에 표시될 텍스트
  final List<Widget> tabs;

  /// 탭바 아래에 표시될 페이지
  final List<Widget> tabViews;

  const CustomTabComponent({
    Key? key,
    required this.tabs,
    required this.tabViews,
  }) : super(key: key);

  @override
  _CustomTabComponentState createState() => _CustomTabComponentState();
}

class _CustomTabComponentState extends State<CustomTabComponent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTabBar(
          tabController: _tabController,
          tabs: widget.tabs,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}

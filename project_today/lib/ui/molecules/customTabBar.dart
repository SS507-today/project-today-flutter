import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Widget> tabs;

  const CustomTabBar({
    Key? key,
    required this.tabController,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelColor: GreyColorSystem.Grey80,
      unselectedLabelColor: GreyColorSystem.Grey60,
      labelStyle: FontSystem.buttonBold,
      unselectedLabelStyle: FontSystem.buttonLight,
      indicator: GradientUnderlineTabIndicator(
        gradient: GredientColorSystem.IndicatorGradient,
        indicatorHeight: 3.0,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: tabs,
    );
  }
}

class GradientUnderlineTabIndicator extends Decoration {
  final BoxPainter _painter;

  GradientUnderlineTabIndicator(
      {required LinearGradient gradient, required double indicatorHeight})
      : _painter = _GradientUnderlinePainter(gradient, indicatorHeight);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _GradientUnderlinePainter extends BoxPainter {
  final Paint _paint;
  final double indicatorHeight;

  _GradientUnderlinePainter(LinearGradient gradient, this.indicatorHeight)
      : _paint = Paint()
          ..shader =
              gradient.createShader(Rect.fromLTWH(0, 0, 100, indicatorHeight))
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Rect rect = Offset(offset.dx, (cfg.size!.height - indicatorHeight)) &
        Size(cfg.size!.width, indicatorHeight);
    canvas.drawRect(rect, _paint);
  }
}

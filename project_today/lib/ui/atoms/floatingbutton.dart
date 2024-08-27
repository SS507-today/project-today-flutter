import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_today/core/constant/colors.dart';

class GradientFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;

  const GradientFloatingActionButton({
    Key? key,
    required this.onPressed,
    this.iconPath = 'assets/icons/ic_add.svg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68.0,
      height: 68.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: GredientColorSystem.FabGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: onPressed,
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 24.0,
              height: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}

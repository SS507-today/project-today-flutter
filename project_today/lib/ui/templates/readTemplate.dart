import 'package:flutter/material.dart';
import 'package:project_today/ui/atoms/index.dart';
import 'package:project_today/ui/organisms/index.dart';

class ReadTemplates extends StatelessWidget {
  final List<String> dates;
  final List<String> imageUrls;
  final List<Map<String, String>> userInfo;
  final VoidCallback? onWriteButtonPressed;
  final bool showButton;

  const ReadTemplates({
    super.key,
    required this.dates,
    required this.imageUrls,
    required this.userInfo,
    this.onWriteButtonPressed,
    this.showButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(showBackButton: true),
        Expanded(
          child: SingleChildScrollView(
            child: ImageCarouselWithProfile(
              dates: dates,
              imageUrls: imageUrls,
              userInfo: userInfo,
            ),
          ),
        ),
        if (showButton)
          DefaultActionButton(
            text: '일기 쓰기',
            onPressed: onWriteButtonPressed ?? () {},
            isActive: true,
          ),
      ],
    );
  }
}

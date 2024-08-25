import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/core/constant/fonts.dart';

class Header extends StatelessWidget {
  final Color backgroundColor;
  final bool showBackButton;
  final String? title;
  final bool showNotificationIcon;
  final bool showSettingsIcon;
  final String? barImage;

  const Header({
    super.key,
    this.backgroundColor = ColorSystem.White,
    this.showBackButton = false,
    this.title,
    this.showNotificationIcon = false,
    this.showSettingsIcon = false,
    this.barImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 13, 20, 13),
      width: MediaQuery.of(context).size.width,
      height: 58,
      alignment: Alignment.center,
      child: Stack(
        children: [
          // Left side: Back button or logo
          Align(
            alignment: Alignment.centerLeft,
            child: showBackButton
                ? ImgButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    iconPath: 'assets/icons/ic_arrow_left.svg',
                  )
                : barImage != null
                    ? Image.asset(barImage!, height: 32)
                    : SizedBox.shrink(),
          ),

          // Center: Title if provided
          if (title != null)
            Align(
              alignment: Alignment.center,
              child: Text(title!,
                  textAlign: TextAlign.center,
                  style: FontSystem.buttonBold
                      .copyWith(color: GreyColorSystem.Grey70)),
            ),

          // Right side: Notification and Settings icons
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showNotificationIcon)
                  ImgButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/alarm');
                    },
                    iconPath: 'assets/icons/ic_alarm.svg',
                  ),
                if (showSettingsIcon)
                  ImgButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/setting');
                    },
                    iconPath: 'assets/icons/ic_setting.svg',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImgButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  const ImgButton({super.key, required this.onPressed, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: 32,
        minHeight: 32,
      ),
      onPressed: onPressed,
      icon: SvgPicture.asset(iconPath),
    );
  }
}

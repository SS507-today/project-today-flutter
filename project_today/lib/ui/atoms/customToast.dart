import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_today/core/constant/colors.dart';

enum ToastType {
  POSITIVE,
  NEGATIVE,
}

class CustomToast extends StatelessWidget {
  /// 토스트 메세지
  final String text;

  /// 토스트 타입
  final ToastType type;

  /// 토스트 메세지 노출 시간 (in milliseconds)
  final int duration;

  const CustomToast({
    super.key,
    required this.text,
    required this.type,
    this.duration = 3000, // Default duration set to 3 seconds
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: GreyColorSystem.Grey40,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            type == ToastType.POSITIVE
                ? 'assets/icons/toast_success.svg'
                : 'assets/icons/toast_error.svg',
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

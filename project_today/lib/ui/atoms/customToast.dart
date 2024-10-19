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

class CustomToastManager {
  static final CustomToastManager _instance = CustomToastManager._internal();
  late OverlayState _overlayState;
  OverlayEntry? _overlayEntry;

  factory CustomToastManager() {
    return _instance;
  }

  CustomToastManager._internal();

  // 초기화 함수: 앱 시작 시 호출하여 Overlay 상태를 저장
  void init(BuildContext context) {
    _overlayState = Overlay.of(context)!;
  }

  // 토스트 메시지를 표시하는 함수
  void showCustomToast({
    required String message,
    required ToastType type,
    int duration = 3000, // Default duration of 3 seconds
  }) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100.0,
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: CustomToast(
              text: message,
              type: type,
              duration: duration,
            ),
          ),
        ),
      ),
    );

    _overlayState.insert(_overlayEntry!);

    Future.delayed(Duration(milliseconds: duration), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}

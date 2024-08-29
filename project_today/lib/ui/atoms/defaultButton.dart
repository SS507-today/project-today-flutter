import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';

class DefaultActionButton extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼이 눌렸을 때 실행될 콜백 함수
  final VoidCallback onPressed;

  /// 버튼이 활성화된 상태인지 여부
  final bool isActive;

  /// 버튼의 너비 : width 값 받으면 그 값 사용, 없으면 화면의 가로 너비 채움
  final double? width;

  /// 버튼 텍스트 색상
  final Color? textColor;

  const DefaultActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isActive,
    this.width,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: width == null
          ? const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0)
          : EdgeInsets.zero,
      child: SizedBox(
        width: width ?? double.infinity,
        height: 58.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isActive ? GreyColorSystem.Grey80 : GreyColorSystem.Grey30,
            foregroundColor: textColor,
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          onPressed: isActive ? onPressed : null,
          child: Text(text),
        ),
      ),
    );
  }
}

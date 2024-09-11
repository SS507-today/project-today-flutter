import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';

class DefaultListEl extends StatelessWidget {
  /// 요소 매인 텍스트
  final String title;

  /// 요소 설명 텍스트
  final String? desc;

  /// 버튼이 눌렸을 때 실행될 콜백 함수
  final VoidCallback onPressed;

  /// 화살표 아이콘 노출 여부
  final bool isShowArrow;

  const DefaultListEl({
    super.key,
    required this.title,
    required this.onPressed,
    this.desc,
    this.isShowArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 20.0),
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
          color: GreyColorSystem.Grey3,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: GreyColorSystem.Grey10,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: GreyColorSystem.Grey80,
              ),
            ),
            Row(
              children: [
                if (desc != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      desc!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: GreyColorSystem.Grey50,
                      ),
                    ),
                  ),
                if (isShowArrow)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.0,
                    color: GreyColorSystem.Grey40,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

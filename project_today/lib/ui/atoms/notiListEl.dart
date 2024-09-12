import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';

enum NotiType {
  DEFAULT,
}

class NotiListEl extends StatelessWidget {
  /// 알림 내용
  final String content;

  /// 알림 하단 설명 텍스트
  final String desc;

  /// 알림 타입
  final NotiType type;

  /// 알림 요소 클릭 시 호출되는 콜백함수
  final VoidCallback onPressed;

  /// 알림 읽었는지 여부
  final bool isChecked;

  const NotiListEl({
    super.key,
    required this.content,
    required this.desc,
    required this.type,
    required this.onPressed,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 110.0,
        decoration: BoxDecoration(
          color: GreyColorSystem.Grey3,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.0,
                    child: Text(
                      content,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: GreyColorSystem.Grey80,
                      ),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        desc,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: GreyColorSystem.Grey50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!isChecked)
              Positioned(
                right: 14.0,
                top: 12.0,
                child: Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: ColorSystem.Red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

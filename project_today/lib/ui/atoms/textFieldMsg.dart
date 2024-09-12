import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_today/core/constant/index.dart';

enum TextFieldMsgType {
  POSITIVE,
  NEGATIVE,
}

class TextFieldMsg extends StatelessWidget {
  /// 텍스트 필드 타입
  final TextFieldMsgType type;

  /// 텍스트 필드 아래에 나타날 메세지
  final String text;

  const TextFieldMsg({
    super.key,
    required this.type,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
        type == TextFieldMsgType.POSITIVE ? ColorSystem.Green : ColorSystem.Red;

    return Row(
      children: [
        SvgPicture.asset(type == TextFieldMsgType.POSITIVE
            ? 'assets/icons/ic_toast_success.svg'
            : 'assets/icons/ic_toast_error.svg'),
        SizedBox(width: 8),
        Text(
          text,
          style: FontSystem.body2.copyWith(color: color),
        ),
      ],
    );
  }
}

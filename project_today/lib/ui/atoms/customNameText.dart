import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';

class CustomNameText extends StatefulWidget {
  /// 이름
  final String name;

  /// 이름 옆 텍스트
  final String topText;

  /// 아래 텍스트
  final String bottomText;

  /// 타이머가 종료되는 시간 (DateTime)
  final DateTime? createdAt;

  const CustomNameText({
    super.key,
    this.name = "",
    this.topText = "",
    this.bottomText = "",
    this.createdAt,
  });

  @override
  _CustomNameTextState createState() => _CustomNameTextState();
}

class _CustomNameTextState extends State<CustomNameText> {
  Duration _remainingTime = Duration(); // 남은 시간
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    if (widget.createdAt != null) {
      _startTimer(); // 타이머 시작
    }
  }

  // 타이머 시작 함수
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (widget.createdAt != null && now.isBefore(widget.createdAt!)) {
        setState(() {
          _remainingTime = widget.createdAt!.difference(now);
        });
      } else {
        setState(() {
          _remainingTime = Duration.zero;
        });
        timer.cancel(); // 시간이 끝나면 타이머 종료
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime() {
    String minutesStr =
        _remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    String secondsStr =
        _remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: FontSystem.buttonBold
                  .copyWith(color: GreyColorSystem.Grey90, fontSize: 18),
            ),
            Text(
              widget.topText,
              textAlign: TextAlign.center,
              style: FontSystem.buttonLight
                  .copyWith(color: GreyColorSystem.Grey90, fontSize: 18),
            ),
          ],
        ),
        Text(
          widget.bottomText,
          style: FontSystem.buttonLight
              .copyWith(color: GreyColorSystem.Grey90, fontSize: 18),
        ),
        if (widget.createdAt != null && _remainingTime > Duration.zero)
          Text(
            "자동 시작까지 ${_formatTime()} 남았어요",
            style: FontSystem.buttonLight
                .copyWith(color: GreyColorSystem.Grey90, fontSize: 18),
          ),
      ],
    );
  }
}

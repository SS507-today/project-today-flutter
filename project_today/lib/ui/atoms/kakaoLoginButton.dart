import 'package:flutter/material.dart';

class KakaoLoginButton extends StatelessWidget {
  /// 카카오 로그인 실행 콜백 함수
  final VoidCallback onPressed;

  const KakaoLoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      width: double.infinity,
      height: 53,
      child: GestureDetector(
        onTap: onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/kakao.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

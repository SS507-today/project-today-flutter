import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFEE500), // 배경색 설정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/ic_kakao_login.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              '카카오 로그인',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

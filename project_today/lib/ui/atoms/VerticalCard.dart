import 'package:flutter/material.dart';

class VerticalCard extends StatelessWidget {
  /// 배경 이미지 경로
  final String? imgPath;

  /// 요소 설명 텍스트
  final String? desc;

  /// 버튼이 눌렸을 때 실행될 콜백 함수
  final VoidCallback? onPressed;

  /// 스켈레톤을 위한 로딩 상태
  final bool isLoading;

  const VerticalCard({
    super.key,
    required this.isLoading,
    this.imgPath,
    this.desc,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 169.0,
        height: 225.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: isLoading ? _buildSkeleton() : _buildContent(),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Column(
      children: [
        Container(
          width: 169.0,
          height: 158.0,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(14.0), // 모서리 둥글게 설정
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          width: 120.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0), // 텍스트 스켈레톤도 둥글게 설정
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          width: 100.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0), // 텍스트 스켈레톤도 둥글게 설정
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        Container(
          width: 185.0,
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            image: DecorationImage(
              image: AssetImage(imgPath!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 67.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.63),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(14.0),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              desc!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

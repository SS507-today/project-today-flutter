import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:project_today/core/constant/index.dart';

class CustomMeshGradientBox extends StatefulWidget {
  ///박스 가로 길이
  final double width;

  ///박스 세로 길이
  final double height;

  ///탭 했을 때 실행 될 콜백 함수 (null 일 시 아무것도 실행 X)
  final VoidCallback? onTap;

  const CustomMeshGradientBox({
    Key? key,
    this.width = 231,
    this.height = 307,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomMeshGradientBoxState createState() => _CustomMeshGradientBoxState();
}

class _CustomMeshGradientBoxState extends State<CustomMeshGradientBox>
    with TickerProviderStateMixin {
  late final MeshGradientController _controller;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    // MeshGradientController 초기화
    _controller = MeshGradientController(
      points: [
        MeshGradientPoint(
          position: const Offset(-1, 0.2),
          color: PinkColorSystem.Pink70,
        ),
        MeshGradientPoint(
          position: const Offset(2, 0.6),
          color: const Color(0xFFF19DB2),
        ),
        MeshGradientPoint(
          position: const Offset(0.7, 0.3),
          color: const Color(0xFFF3BD8B),
        ),
        MeshGradientPoint(
          position: const Offset(0.4, 0.8),
          color: const Color.fromARGB(255, 255, 81, 0),
        ),
      ],
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  void _startAnimation() async {
    while (!_isDisposed) {
      try {
        if (_isDisposed) return;
        await _controller.animateSequence(
          duration: const Duration(seconds: 2),
          sequences: [
            for (int i = 0; i < _controller.points.value.length; i++)
              AnimationSequence(
                pointIndex: i,
                newPoint: MeshGradientPoint(
                  position: Offset(
                    Random().nextDouble() * 2 - 0.5,
                    Random().nextDouble() * 2 - 0.5,
                  ),
                  color: _controller.points.value[i].color,
                ),
                interval: Interval(
                  i * 0.25,
                  1.0,
                  curve: Curves.easeInOut,
                ),
              ),
          ],
        );
      } catch (e) {
        if (_isDisposed) return;
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {}, // onTap이 null이면 아무 동작도 하지 않음
      child: Stack(
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: GredientColorSystem.BorderGradient,
            ),
          ),
          Positioned(
            top: 2,
            left: 2,
            child: GestureDetector(
              onTap: widget.onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: widget.width - 4, // 경계선 크기를 뺀 너비
                  height: widget.height - 4, // 경계선 크기를 뺀 높이
                  color: Colors.white,
                  child: MeshGradient(
                    controller: _controller,
                    options: MeshGradientOptions(
                      blend: 3.5,
                      noiseIntensity: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

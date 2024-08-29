import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/core/constant/fonts.dart';
import 'package:project_today/ui/atoms/defaultButton.dart';
import 'package:project_today/ui/organisms/header.dart';

class ArriveScreen extends StatefulWidget {
  const ArriveScreen({super.key});

  @override
  State<ArriveScreen> createState() => _ArriveScreenState();
}

class _ArriveScreenState extends State<ArriveScreen>
    with TickerProviderStateMixin {
  late final MeshGradientController _controller;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    // MeshGradientController를 초기화합니다.
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
        if (_isDisposed) return; // dispose 된 상태에서 애니메이션을 시작하지 않음
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
        if (_isDisposed) return; // dispose 된 상태라면 애니메이션을 중단
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
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Header(
              showBackButton: true,
              title: "SS507",
              showSettingsIcon: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      '새로운 일기를 담은 \n 교환일기가 도착했어요!',
                      textAlign: TextAlign.center,
                      style: FontSystem.title
                          .copyWith(color: GreyColorSystem.Grey90),
                    ),
                    SizedBox(
                      height: 38.0,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 231, // 사각형의 크기 + 경계 너비
                          height: 307, // 사각형의 크기 + 경계 너비
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: GredientColorSystem.BorderGradient,
                          ),
                        ),
                        Positioned(
                          top: 1,
                          left: 1,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(15), // 내부 사각형의 모서리 둥글게
                            child: Container(
                              width: 229,
                              height: 305, // 사각형의 크기
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
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultActionButton(
                    width: 103,
                    text: '일기장',
                    onPressed: onPressed,
                    isActive: false,
                  ),
                  SizedBox(
                    width: 13.0,
                  ),
                  DefaultActionButton(
                    width: 242,
                    text: '일기 쓰기',
                    onPressed: () {
                      Navigator.pushNamed(context, '/write');
                    },
                    isActive: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    // 아무 작업도 하지 않음
  }
}

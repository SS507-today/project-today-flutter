import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/core/constant/fonts.dart';
import 'package:project_today/ui/atoms/defaultButton.dart';
import 'package:project_today/ui/molecules/ruleCard.dart';
import 'package:project_today/ui/organisms/header.dart';
import 'package:avatar_glow/avatar_glow.dart';

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
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            const Header(
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
                    AvatarGlow(
                      startDelay: const Duration(milliseconds: 1000),
                      glowColor: PinkColorSystem.Pink30,
                      glowShape: BoxShape.circle,
                      curve: Curves.fastOutSlowIn,
                      child: Stack(
                        children: [
                          Container(
                            width: 231,
                            height: 307,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: GredientColorSystem.BorderGradient,
                            ),
                          ),
                          Positioned(
                            top: 1,
                            left: 1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/week');
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: 229,
                                  height: 305,
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
                    ),
                    SizedBox(
                      height: 17.0,
                    ),
                    RuleCard(
                      title: '규칙 1',
                      content: '까먹지 않고 꼭 쓰기',
                    ),
                    RuleCard(
                      title: '규칙 2',
                      content: '남의 험담은 하지 않기~',
                    ),
                    RuleCard(
                      title: '규칙 3',
                      content: '성의있게 쓰기~!',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                child: DefaultActionButton(
                  text: '지난 일기장',
                  onPressed: onPressed,
                  isActive: true,
                )),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    // 아무 작업도 하지 않음
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/core/constant/fonts.dart';
import 'package:project_today/ui/atoms/index.dart';
import 'package:project_today/ui/molecules/index.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageCarouselWithProfile extends StatefulWidget {
  /// 상단 날짜
  final List<String> dates;

  /// 이미지 URL
  final List<String> imageUrls;

  /// 프로필 정보
  final List<Map<String, String>> userInfo;

  const ImageCarouselWithProfile({
    Key? key,
    required this.dates,
    required this.imageUrls,
    required this.userInfo,
  }) : super(key: key);

  @override
  _ImageCarouselWithProfileState createState() =>
      _ImageCarouselWithProfileState();
}

class _ImageCarouselWithProfileState extends State<ImageCarouselWithProfile> {
  int currentPageIndex = 0;
  bool _enabled = true;

  void onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;

      _enabled = true;
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _enabled = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // 2초 후에 _enabled를 false로 설정
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _enabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///날짜
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 17, 0, 43),
          child: Text(
            widget.dates[currentPageIndex],
            style: FontSystem.title.copyWith(color: GreyColorSystem.Grey70),
          ),
        ),

        /// 이미지 캐러셀
        CustomImageCarousel(
          imageUrls: widget.imageUrls,
          onPageChanged: onPageChanged, // 페이지가 변경될 때 호출
        ),

        /// 일기 작성자 프로필
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 43, 20, 0),
          child: Skeletonizer(
            enabled: _enabled,
            enableSwitchAnimation: true,
            child: ImgListEl(
              imgPath: widget.userInfo[currentPageIndex]['imgPath']!,
              title: widget.userInfo[currentPageIndex]['name']!,
              desc: widget.userInfo[currentPageIndex]['role']!,
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}

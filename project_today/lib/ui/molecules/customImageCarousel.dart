import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomImageCarousel extends StatefulWidget {
  ///이미지 url 배열
  final List<String> imageUrls;

  ///뷰포트 비율
  final double viewportFraction;

  /// 박스 높이
  final double height;

  const CustomImageCarousel({
    Key? key,
    required this.imageUrls,
    this.viewportFraction = 0.618,
    this.height = 324,
  }) : super(key: key);

  @override
  _CustomImageCarouselState createState() => _CustomImageCarouselState();
}

class _CustomImageCarouselState extends State<CustomImageCarousel> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: widget.viewportFraction,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 16),
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade200, // 이미지를 불러오기 전의 배경색
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 33),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.imageUrls.length,
          effect: const WormEffect(
            dotHeight: 8.38,
            dotWidth: 8.38,
            dotColor: GreyColorSystem.Grey20,
            activeDotColor: GreyColorSystem.Grey70,
          ),
        ),
      ],
    );
  }
}

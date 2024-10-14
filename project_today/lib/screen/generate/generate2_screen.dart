import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class GeneratePage2 extends StatelessWidget {
  final List<String> coverList;
  final int selectedCoverIndex;
  final Function(int) onCoverSelected;

  const GeneratePage2({
    required this.coverList,
    required this.selectedCoverIndex,
    required this.onCoverSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width; // 화면 너비 가져오기
    final double cardWidth = screenWidth * 0.7; // 화면의 70% 너비
    final double cardHeight = cardWidth * 1.33; // 너비, 높이 비율 따른 계산

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: SizedBox(
        child: AppinioSwiper(
          cardCount: coverList.length,
          loop: true,
          backgroundCardCount: 1,
          backgroundCardScale: 0.9,
          cardBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                width: cardWidth,
                height: cardHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage(coverList[index]),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            );
          },
          onSwipeEnd:
              (int previousIndex, int currentIndex, SwiperActivity activity) {
            onCoverSelected(currentIndex + 1);
          },
        ),
      ),
    );
  }
}

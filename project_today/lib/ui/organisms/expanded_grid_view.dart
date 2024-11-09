import 'package:flutter/material.dart';
import 'package:project_today/ui/atoms/VerticalCard.dart';

class ExpandedGridView extends StatelessWidget {
  final List<Map<String, dynamic>> groupData;
  final bool isLoading;

  const ExpandedGridView({
    required this.groupData,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      shrinkWrap: true, // GridView가 `Column` 내부에서 작동하도록 함
      physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
      itemCount: groupData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final group = groupData[index];
        return VerticalCard(
          imgPath: group['imgsrc'] as String,
          desc: group['desc'] as String,
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/read',
              arguments: {
                'bundleId': group['id'],
                'isWeek': false,
              },
            );
          },
          isLoading: isLoading,
        );
      },
    );
  }
}

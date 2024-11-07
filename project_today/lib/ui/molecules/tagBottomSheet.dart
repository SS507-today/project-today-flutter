import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/atoms/index.dart';

class TagBottomSheet extends StatelessWidget {
  /// 멤버들의 정보가 담긴 리스트 (최대 6명)
  final List<Map<String, String>> members;

  const TagBottomSheet({
    super.key,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '태그 할 친구',
            style:
                FontSystem.buttonBold.copyWith(color: GreyColorSystem.Grey70),
          ),
          const SizedBox(height: 16),
          ..._buildTagRows(),
        ],
      ),
    );
  }

  /// 멤버 수에 따라 행(row) 구조 조정
  List<Widget> _buildTagRows() {
    List<Widget> rows = [];
    List<Widget> rowItems = [];

    for (int i = 0; i < members.length; i++) {
      rowItems.add(
        TagListEl(
          name: members[i]['name'] ?? '',
          imgPath: members[i]['imgPath'] ?? '',
        ),
      );

      // 3명마다 줄바꿈, 혹은 마지막 요소 추가 시
      if ((i + 1) % 3 == 0 || i == members.length - 1) {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: rowItems,
        ));
        rows.add(const SizedBox(height: 16));
        rowItems = []; // 새 행을 위해 초기화
      }
    }

    return rows;
  }
}

// showModalBottomSheet 호출 함수
void showTagBottomSheet(
    BuildContext context, List<Map<String, String>> members) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorSystem.White,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (BuildContext context) {
      return TagBottomSheet(members: members);
    },
  );
}

import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/ui/atoms/index.dart';

class TagBottomSheet extends StatelessWidget {
  /// 멤버들의 정보가 담긴 리스트 (최대 5명)
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

  /// 멤버들을 2명씩 묶어서 행(row)으로 반환
  List<Widget> _buildTagRows() {
    List<Widget> rows = [];
    for (int i = 0; i < members.length; i += 2) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TagListEl(
              name: members[i]['name'] ?? '',
              imgPath: members[i]['imgPath'] ?? '',
            ),
            // 두 번째 멤버가 있으면 표시, 없으면 빈 공간
            if (i + 1 < members.length)
              TagListEl(
                name: members[i + 1]['name'] ?? '',
                imgPath: members[i + 1]['imgPath'] ?? '',
              ),
            if (i + 1 >= members.length) SizedBox(width: 72), // 빈 공간
          ],
        ),
      );
      if (i + 2 < members.length) {
        rows.add(const SizedBox(height: 16));
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

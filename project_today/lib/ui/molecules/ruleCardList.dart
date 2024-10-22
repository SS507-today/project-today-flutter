import 'package:flutter/material.dart';
import 'package:project_today/ui/atoms/index.dart';

class RuleCardList extends StatelessWidget {
  final List<Map<String, String?>> rules; // title과 content를 담은 리스트

  const RuleCardList({
    Key? key,
    required this.rules,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: rules.map((rule) {
        return Padding(
          padding: const EdgeInsets.only(top: 10), // 각 RuleCard 사이 간격
          child: RuleCardListEl(
            title: rule['title'], // title은 nullable
            content: rule['content'] ?? '', // content는 nullable이 아니므로 기본값 '' 처리
          ),
        );
      }).toList(),
    );
  }
}

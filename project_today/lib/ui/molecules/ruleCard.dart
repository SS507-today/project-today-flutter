import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/core/constant/fonts.dart';

class RuleCard extends StatelessWidget {
  final String title;
  final String content;

  const RuleCard({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                FontSystem.buttonBold.copyWith(color: GreyColorSystem.Grey70),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: GreyColorSystem.Grey3,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              content,
              style: FontSystem.body2
                  .copyWith(color: GreyColorSystem.Grey70, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

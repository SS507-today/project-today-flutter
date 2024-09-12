import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';

class RuleCardListEl extends StatelessWidget {
  final String? title;
  final String content;

  const RuleCardListEl({
    Key? key,
    this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty)
          Text(
            title!,
            style:
                FontSystem.buttonBold.copyWith(color: GreyColorSystem.Grey70),
          ),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: GreyColorSystem.Grey3,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Text(
            content,
            style: FontSystem.body2.copyWith(
              color: GreyColorSystem.Grey70,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

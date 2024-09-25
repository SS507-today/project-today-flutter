import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneratePage3 extends StatelessWidget {
  final List<String> rules;
  final Function(int) onRemoveRule;
  final Function(BuildContext, int) onAddRule;

  const GeneratePage3({
    required this.rules,
    required this.onRemoveRule,
    required this.onAddRule,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          ...List.generate(rules.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '규칙 ${index + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: GreyColorSystem.Grey70,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => onRemoveRule(index),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_trash.svg',
                                  width: 16,
                                  height: 16,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '삭제',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: GreyColorSystem.Grey3,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      rules[index],
                      style: const TextStyle(
                        fontSize: 15,
                        color: GreyColorSystem.Grey70,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 20),
          if (rules.length < 3) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '규칙 ${rules.length + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => onAddRule(context, rules.length + 1),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  color: GreyColorSystem.Grey3,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.add,
                  color: GreyColorSystem.Grey70,
                  size: 24,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/customTextField.dart';

class GeneratePage1 extends StatelessWidget {
  ///인풋 체인지 함수
  final Function(String) onGroupNameChanged;
  final Function(String) onGroupDescriptionChanged;
  final Function(double) onGroupSizeChanged;
  final double groupSize;

  const GeneratePage1({
    required this.onGroupNameChanged,
    required this.onGroupDescriptionChanged,
    required this.onGroupSizeChanged,
    required this.groupSize,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Text(
            '그룹명',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: GreyColorSystem.Grey80,
            ),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            hintText: "1-15자 이내로 입력해 주세요",
            onChanged: onGroupNameChanged,
          ),
          const SizedBox(height: 40),
          const Text(
            '그룹 인원수',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: GreyColorSystem.Grey80,
            ),
          ),
          const SizedBox(height: 12),
          Slider(
            value: groupSize,
            min: 0,
            max: 6,
            divisions: 6,
            label: groupSize > 0 ? "${groupSize.toInt()}명" : "선택 안 됨",
            activeColor: PinkColorSystem.Pink,
            inactiveColor: PinkColorSystem.Pink60,
            onChanged: onGroupSizeChanged,
          ),
          const SizedBox(height: 40),
          const Text(
            '그룹 소개',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: GreyColorSystem.Grey80,
            ),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            hintText: "1-50자 이내로 입력해 주세요",
            onChanged: onGroupDescriptionChanged,
          ),
        ],
      ),
    );
  }
}

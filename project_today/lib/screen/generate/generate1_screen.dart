import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/core/constant/fonts.dart';
import 'package:project_today/ui/atoms/customTextField.dart';

class GeneratePage1 extends StatelessWidget {
  /// 인풋 체인지 함수
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
    // groupSize 값이 min과 max 범위 내에 있는지 확인하고, 범위를 벗어나면 조정
    final adjustedGroupSize = groupSize.clamp(2.0, 6.0);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text('그룹명',
              style: FontSystem.buttonBold
                  .copyWith(color: GreyColorSystem.Grey80)),
          const SizedBox(height: 12),
          CustomTextField(
            hintText: "1-15자 이내로 입력해 주세요",
            onChanged: onGroupNameChanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(15),
            ],
          ),
          const SizedBox(height: 40),
          Text('그룹 인원수',
              style: FontSystem.buttonBold
                  .copyWith(color: GreyColorSystem.Grey80)),
          const SizedBox(height: 12),
          Slider(
            value: adjustedGroupSize, // 수정된 groupSize 사용
            min: 2,
            max: 6,
            divisions: 4, // 인원수를 2, 3, 4, 5, 6으로 나눔
            label: "${adjustedGroupSize.toInt()}명",
            activeColor: PinkColorSystem.Pink,
            inactiveColor: PinkColorSystem.Pink60,
            onChanged: onGroupSizeChanged,
          ),
          const SizedBox(height: 40),
          Text('그룹 소개',
              style: FontSystem.buttonBold
                  .copyWith(color: GreyColorSystem.Grey80)),
          const SizedBox(height: 12),
          CustomTextField(
            hintText: "1-50자 이내로 입력해 주세요",
            onChanged: onGroupDescriptionChanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
          ),
        ],
      ),
    );
  }
}

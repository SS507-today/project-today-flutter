import 'package:flutter/material.dart';
import 'package:project_today/core/constant/colors.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: 324,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coverList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () => onCoverSelected(index),
                    child: Container(
                      width: 243,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: AssetImage(coverList[index]),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: selectedCoverIndex == index
                              ? GredientColorSystem.BorderOrange
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

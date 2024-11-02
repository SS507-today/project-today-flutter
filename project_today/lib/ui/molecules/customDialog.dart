import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String leftText;
  final String rightText;
  final VoidCallback onConfirm;

  CustomDialog({
    required this.title,
    required this.leftText,
    required this.rightText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorSystem.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 22.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 43.0),
            Text(
              title,
              style: FontSystem.buttonLight
                  .copyWith(color: GreyColorSystem.Grey70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GreyColorSystem.Grey10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: Text(
                      leftText,
                      style: FontSystem.buttonLight
                          .copyWith(color: GreyColorSystem.Grey60),
                    ),
                  ),
                )),
                SizedBox(width: 8.0),
                Expanded(
                    child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      onConfirm();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GreyColorSystem.Grey80,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: Text(
                      rightText,
                      style: FontSystem.buttonLight
                          .copyWith(color: ColorSystem.White),
                    ),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 다이얼로그를 표시하는 함수
void showCustomDialog(BuildContext context, String title, String leftText,
    String rightText, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        title: title,
        leftText: leftText,
        rightText: rightText,
        onConfirm: onConfirm,
      );
    },
  );
}

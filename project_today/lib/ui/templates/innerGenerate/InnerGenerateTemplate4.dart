import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_today/core/constant/colors.dart'; // 색상 관련 상수는 여기에서 정의된 것으로 가정
import 'package:project_today/ui/atoms/customToast.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneratePage4 extends StatelessWidget {
  final String url = "https://today.com/w/main/minjinjorlidayobbbb";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: GreyColorSystem.Grey10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      url,
                      style: const TextStyle(
                        fontSize: 16,
                        color: GreyColorSystem.Grey80,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: GreyColorSystem.Grey5,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: SvgPicture.asset(
                  'assets/icons/ic_link_copy.svg',
                  width: 30,
                  height: 30,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showToast(context, '링크 복사 완료!');
  }

  void _showToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100.0,
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: CustomToast(
              text: message,
              type: ToastType.POSITIVE,
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/customToast.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneratePage4 extends StatelessWidget {
  final String inviteCode;

  const GeneratePage4({required this.inviteCode});

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
                      inviteCode,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: GreyColorSystem.Grey80,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => _copyToClipboard(context, inviteCode),
                child: Container(
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showToast(context, '초대 코드 복사 완료!');
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

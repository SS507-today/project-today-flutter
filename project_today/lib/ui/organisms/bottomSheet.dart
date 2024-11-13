import 'package:flutter/material.dart';
import 'package:project_today/ui/atoms/customToast.dart';

//TODO 바텀시트 자체만 두고, 기능 내용은 위에서 관리해야 할듯

class BottomSheetWidget extends StatelessWidget {
  // 인풋 컨트롤러 (미지정시 기본)
  final TextEditingController ruleController;
  // 인풋 컨트롤러에 의해 포커할 인풋
  final FocusNode focusNode;
  // 현재 생성된 규칙 번호
  final int ruleNumber;
  // 확인 클릭 콜백 함수
  final ValueChanged<String> onSubmitted;

  const BottomSheetWidget({
    Key? key,
    required this.ruleController,
    required this.focusNode,
    required this.ruleNumber,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ruleController.addListener(() {
      if (ruleController.text.length >= 30) {
        _showToast(context, "최대 30자만 입력할 수 있어요");
      }
    });

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '규칙 $ruleNumber',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: ruleController,
                  focusNode: focusNode,
                  autofocus: true,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: "30자 이내로 입력해 주세요",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    counterText: "",
                  ),
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      onSubmitted(value);
                      ruleController.clear();
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(builder: (context) {
      double bottomOffset = MediaQuery.of(context).viewInsets.bottom + 180.0;

      return Positioned(
        bottom: bottomOffset,
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: CustomToast(
              text: message,
              type: ToastType.NEGATIVE,
            ),
          ),
        ),
      );
    });

    overlay?.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

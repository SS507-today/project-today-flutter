import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_today/core/constant/index.dart';

class CustomTextField extends StatefulWidget {
  ///테두리 색상
  final Color borderColor;

  ///폰트 색상
  final Color inputColor;

  ///힌트 메세지
  final String hintText;

  ///텍스트 변경 시 호출되는 콜백 함수
  final ValueChanged<String>? onChanged;

  ///외부에서 전달받는 TextEditingController
  final TextEditingController? controller;

  ///인풋 포맷터
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    this.borderColor = GreyColorSystem.Grey3,
    this.inputColor = GreyColorSystem.Grey70,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  // controller가 전달되지 않으면 내부에서 컨트롤러 생성
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose(); // 외부에서 전달된 경우에는 dispose하지 않음
    }
    super.dispose();
  }

  InputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: widget.borderColor, width: 2.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: PinkColorSystem.Pink60.withOpacity(0.4),
        selectionHandleColor: PinkColorSystem.Pink60,
      ),
      child: TextFormField(
        focusNode: _focusNode,
        controller: _controller,
        style: FontSystem.buttonLight.copyWith(color: widget.inputColor),
        cursorColor: PinkColorSystem.Pink,
        decoration: InputDecoration(
          filled: true,
          fillColor: GreyColorSystem.Grey3,
          hintText: widget.hintText,
          hintStyle:
              FontSystem.buttonLight.copyWith(color: GreyColorSystem.Grey30),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(),
          errorBorder: _buildBorder(),
          focusedErrorBorder: _buildBorder(),
          suffixIcon: IconButton(
            icon: SvgPicture.asset('assets/icons/ic_clear.svg'),
            onPressed: () {
              _controller.clear();
              if (widget.onChanged != null) {
                widget.onChanged!('');
              }
            },
          ),
        ),
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}

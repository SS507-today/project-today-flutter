import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_today/core/constant/index.dart';

class CustomTextField extends StatefulWidget {
  ///테두리 색상
  final Color borderColor;

  ///폰트 색상
  final Color inputColor;

  ///힌트 메세지
  final String hintText;

  const CustomTextField({
    Key? key,
    this.borderColor = GreyColorSystem.Grey3,
    this.inputColor = GreyColorSystem.Grey70,
    required this.hintText,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
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
            },
          ),
        ),
      ),
    );
  }
}

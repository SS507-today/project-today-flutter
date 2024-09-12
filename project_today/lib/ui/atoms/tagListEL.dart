import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_today/core/constant/index.dart';

class TagListEl extends StatefulWidget {
  /// 요소 메인 텍스트
  final String name;

  /// 요소 원형 이미지 경로
  final String imgPath;

  const TagListEl({
    super.key,
    required this.name,
    required this.imgPath,
  });

  @override
  _TagListElState createState() => _TagListElState();
}

class _TagListElState extends State<TagListEl> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 72,
                height: 72,
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(widget.imgPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (_isSelected)
                Container(
                  width: 72,
                  height: 72,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.5), // 불투명한 검은색 오버레이
                  ),
                  child: Center(
                      child:
                          SvgPicture.asset('assets/icons/ic_check_bold.svg')),
                ),
            ],
          ),
          Text(
            widget.name,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: GreyColorSystem.Grey80,
            ),
          ),
        ],
      ),
    );
  }
}

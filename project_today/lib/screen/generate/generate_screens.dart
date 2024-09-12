import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/generate/generate_page_1.dart';
import 'package:project_today/ui/templates/generate/generate_page_2.dart';
import 'package:project_today/ui/templates/generate/generate_page_3.dart';
import 'package:project_today/ui/templates/generate/generate_page_4.dart';
import 'package:project_today/ui/organisms/gradientHeader.dart';
import 'package:project_today/ui/atoms/defaultButton.dart';
import 'package:project_today/core/constant/colors.dart';

class GenerateScreen extends StatefulWidget {
  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  int currentPage = 0;
  bool isButtonActive = false;

  // common gradient header variables
  final List<Map<String, String>> pageHeaders = [
    {'text': '그룹을 소개해 주세요', 'color': 'Pink'},
    {'text': '교환일기 표지를 선택해 주세요', 'color': 'Orange'},
    {'text': '교환일기 규칙을 정해주세요', 'color': 'Pink'},
    {'text': '링크를 공유해 친구를 초대해 보세요', 'color': 'Orange'},
  ];

  // buildPage1 variables
  String groupName = '';
  String groupDescription = '';
  double groupSize = 0;

  // buildPage2 variables
  int selectedCoverIndex = -1;
  final List<String> coverList = [
    'assets/images/temp_bg.png',
    'assets/images/temp_bg.png',
    'assets/images/temp_bg.png',
    'assets/images/temp_bg.png',
  ];

  // buildPage3 variables
  List<String> rules = [];

  // Text controller and focus node for adding rules
  TextEditingController ruleController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  // Validate form inputs for page 1
  void _validateForm() {
    setState(() {
      isButtonActive =
          groupName.isNotEmpty && groupDescription.isNotEmpty && groupSize > 0;
    });
  }

  void _onGroupNameChanged(String value) {
    groupName = value;
    _validateForm();
  }

  void _onGroupDescriptionChanged(String value) {
    groupDescription = value;
    _validateForm();
  }

  void _onGroupSizeChanged(double value) {
    setState(() {
      groupSize = value;
      _validateForm();
    });
  }

  // Page 2
  void _onCoverSelected(int index) {
    setState(() {
      selectedCoverIndex = index;
      isButtonActive = true;
    });
  }

  // Page 3
  void _removeRule(int index) {
    setState(() {
      rules.removeAt(index);
    });
  }

  void _showBottomSheet(BuildContext context, int ruleNumber) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 23,
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
                      focusNode: _focusNode,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "30자 이내로 입력해 주세요",
                        hintStyle: TextStyle(
                          color: GreyColorSystem.Grey30,
                        ),
                        filled: true,
                        fillColor: GreyColorSystem.Grey3,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: GreyColorSystem.Grey3,
                            width: 0.0,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: GreyColorSystem.Grey80,
                      ),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            rules.add(value);
                            ruleController.clear();
                          });
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
      },
    ).whenComplete(() {
      _focusNode.unfocus();
    });

    Future.delayed(Duration(milliseconds: 100), () {
      _focusNode.requestFocus();
    });
  }

  void _onNextPressed() {
    setState(() {
      if (currentPage < 3) {
        currentPage += 1;
      } else {
        Navigator.pushReplacementNamed(context, '/group');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      GeneratePage1(
        onGroupNameChanged: _onGroupNameChanged,
        onGroupDescriptionChanged: _onGroupDescriptionChanged,
        onGroupSizeChanged: _onGroupSizeChanged,
        groupSize: groupSize,
      ),
      GeneratePage2(
        coverList: coverList,
        selectedCoverIndex: selectedCoverIndex,
        onCoverSelected: _onCoverSelected,
      ),
      GeneratePage3(
        rules: rules,
        onRemoveRule: _removeRule,
        onAddRule: _showBottomSheet,
      ),
      GeneratePage4(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            GradientHeader(
              currentPage: currentPage,
              text: pageHeaders[currentPage]['text']!,
              colorType: pageHeaders[currentPage]['color']!,
            ),
            Expanded(
              child: pages[currentPage],
            ),
            DefaultActionButton(
              text: currentPage == 3 ? "그룹 생성 완료" : "다음",
              isActive: isButtonActive,
              onPressed: _onNextPressed,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/generateTemplate.dart';
import 'package:project_today/ui/templates/innerGenerate/InnerGenerateTemplate1.dart';
import 'package:project_today/ui/templates/innerGenerate/InnerGenerateTemplate2.dart';
import 'package:project_today/ui/templates/innerGenerate/InnerGenerateTemplate3.dart';
import 'package:project_today/ui/templates/innerGenerate/InnerGenerateTemplate4.dart';
import 'package:project_today/ui/organisms/bottomSheet.dart';

class GenerateScreen extends StatefulWidget {
  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  int currentPage = 0;
  bool isButtonActive = false;

  final List<Map<String, String>> pageHeaders = [
    {'text': '그룹을 소개해 주세요', 'color': 'Pink'},
    {'text': '교환일기 표지를 선택해 주세요', 'color': 'Orange'},
    {'text': '교환일기 규칙을 정해주세요', 'color': 'Pink'},
    {'text': '링크를 공유해 친구를 초대해 보세요', 'color': 'Orange'},
  ];

  String groupName = '';
  String groupDescription = '';
  double groupSize = 0;

  int selectedCoverIndex = -1;
  final List<String> coverList = [
    'assets/images/temp_bg.png',
    'assets/images/temp_bg.png',
    'assets/images/temp_bg.png',
    'assets/images/temp_bg.png',
  ];

  List<String> rules = [];

  TextEditingController ruleController = TextEditingController();
  FocusNode _focusNode = FocusNode();

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

  void _onCoverSelected(int index) {
    setState(() {
      selectedCoverIndex = index;
      isButtonActive = true;
    });
  }

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
        return BottomSheetWidget(
          ruleController: ruleController,
          focusNode: _focusNode,
          ruleNumber: ruleNumber,
          onSubmitted: (value) {
            setState(() {
              rules.add(value);
            });
          },
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

    return GenerateTemplate(
      currentPage: currentPage,
      headerText: pageHeaders[currentPage]['text']!,
      colorType: pageHeaders[currentPage]['color']!,
      pages: pages,
      isButtonActive: isButtonActive,
      onNextPressed: _onNextPressed,
    );
  }
}

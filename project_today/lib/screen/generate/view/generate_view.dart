import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_today/data/models/detail_group_model.dart';
import 'package:project_today/screen/generate/view_model/generate_view_model.dart';
import 'package:project_today/ui/templates/generateTemplate.dart';
import 'package:project_today/screen/generate/generate1_screen.dart';
import 'package:project_today/screen/generate/generate2_screen.dart';
import 'package:project_today/screen/generate/generate3_screen.dart';
import 'package:project_today/screen/generate/generate4_screen.dart';
import 'package:project_today/ui/organisms/bottomSheet.dart';

/// 그룹 생성 뷰 (GeneratePage1, GeneratePage2, ...)
class GenerateView extends StatefulWidget {
  @override
  _GenerateViewState createState() => _GenerateViewState();
}

class _GenerateViewState extends State<GenerateView> {
  int currentPage = 0;
  bool isButtonActive = false;

  String groupName = '';
  String groupDescription = '';
  double groupSize = 0;
  int selectedCoverIndex = -1;
  List<String> rules = [];

  TextEditingController ruleController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  void _onNextPressed(BuildContext context, GenerateViewModel viewModel) async {
    if (currentPage < 3) {
      if (currentPage == 2) {
        final newGroup = DetailGroupModel(
          name: groupName,
          memberCount: groupSize.toInt(),
          description: groupDescription,
          coverImage: selectedCoverIndex,
          ruleFirst: rules.isNotEmpty ? rules[0] : '',
          ruleSecond: rules.length > 1 ? rules[1] : '',
          ruleThird: rules.length > 2 ? rules[2] : '',
        );

        await viewModel.createGroup(newGroup);

        if (viewModel.inviteCode != null) {
          setState(() {
            currentPage += 1;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('그룹 생성에 실패했습니다. 다시 시도해 주세요.')),
          );
        }
      } else {
        setState(() {
          currentPage += 1;
        });
      }
    } else {
      Navigator.pushReplacementNamed(context, '/group');
    }
  }

  void _validateForm() {
    setState(() {
      isButtonActive =
          groupName.isNotEmpty && groupDescription.isNotEmpty && groupSize > 0;
    });
  }

  void _onGroupNameChanged(String value) {
    setState(() {
      groupName = value;
      _validateForm();
    });
  }

  void _onGroupDescriptionChanged(String value) {
    setState(() {
      groupDescription = value;
      _validateForm();
    });
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
              _validateForm();
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GenerateViewModel(),
      child: Consumer<GenerateViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return GenerateTemplate(
            currentPage: currentPage,
            headerText: '그룹 생성하기',
            colorType: 'Pink',
            pages: [
              GeneratePage1(
                onGroupNameChanged: _onGroupNameChanged,
                onGroupDescriptionChanged: _onGroupDescriptionChanged,
                onGroupSizeChanged: _onGroupSizeChanged,
                groupSize: groupSize,
              ),
              GeneratePage2(
                coverList: [
                  'assets/images/cover/group_1.png',
                  'assets/images/cover/group_2.png',
                  'assets/images/cover/group_3.png',
                  'assets/images/cover/group_4.png',
                  'assets/images/cover/group_5.png',
                  'assets/images/cover/group_6.png',
                ],
                selectedCoverIndex: selectedCoverIndex,
                onCoverSelected: _onCoverSelected,
              ),
              GeneratePage3(
                rules: rules,
                onRemoveRule: _removeRule,
                onAddRule: _showBottomSheet,
              ),
              GeneratePage4(
                inviteCode: viewModel.inviteCode ?? '',
              ),
            ],
            isButtonActive: isButtonActive,
            onNextPressed: () => _onNextPressed(context, viewModel),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_today/ui/templates/participateTemplate.dart';
import 'package:project_today/ui/atoms/customToast.dart';
import 'package:provider/provider.dart';
import 'package:project_today/screen/participate/view_model/participate_view_model.dart'; // ViewModel import
import 'package:project_today/data/models/participate_model.dart';

///참가 코드 입력 뷰
///코드 유효 - /invite에 그룹정보 넘김
///코드 미유효 - 에러 toast 위젯 노출
class ParticipateView extends StatefulWidget {
  @override
  _ParticipateViewState createState() => _ParticipateViewState();
}

class _ParticipateViewState extends State<ParticipateView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParticipateViewModel(),
      child: Consumer<ParticipateViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ParticipateTemplate(
            nickname: viewModel.inviteCode,
            isButtonActive:
                viewModel.inviteCode.isNotEmpty && !viewModel.isLoading,
            onNicknameChanged: (value) {
              viewModel.inviteCode = value;
            },
            onNextPressed: () async {
              if (viewModel.inviteCode.isEmpty) return;

              final ParticipateGroup? response =
                  await viewModel.fetchParticipateGroup();

              if (response != null) {
                Navigator.pushReplacementNamed(
                  context,
                  '/invite',
                  arguments: response,
                );
              } else {
                _showToast(context, '유효하지 않은 참가코드 입니다.');
              }
            },
            titleText: "그룹 참가 코드를 입력해주세요",
            hintText: "그룹 참가 코드",
            errorMsg: "유효하지 않은 참가코드 입니다.",
          );
        },
      ),
    );
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
              type: ToastType.NEGATIVE,
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

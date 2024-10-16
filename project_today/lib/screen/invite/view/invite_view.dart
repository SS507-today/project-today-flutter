import 'package:flutter/material.dart';
import 'package:project_today/data/models/participate_model.dart';
import 'package:project_today/ui/templates/index.dart';
import 'package:provider/provider.dart';
import 'package:project_today/screen/invite/view_model/invite_view_model.dart';
import 'package:project_today/ui/atoms/customToast.dart';

/// shareGroupId로 조회한 참여할 그룹 정보 노출 뷰 <br />
/// `postInvite`에서 리턴받은 boolean에 따라 분기 <br />
/// `true` /group 리다이렉트 <br />
/// `false` 에러 토스트메세지 노출 <br />
class InviteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ParticipateGroup? participateGroup =
        ModalRoute.of(context)?.settings.arguments as ParticipateGroup?;

    if (participateGroup == null) {
      return Scaffold(
        body: Center(
          child: Text('유효하지 않은 데이터입니다.'),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => InviteViewModel(),
      child: Consumer<InviteViewModel>(
        builder: (context, viewModel, child) {
          return Diaryhometemplate(
            headerTitle: participateGroup.groupName,
            name: participateGroup.ownerName,
            topText: "님 외 ${participateGroup.memberCount - 1}명이",
            bottomText: "오늘을 교환하고 싶어해요",
            imgPath: 'assets/images/cover/group_${participateGroup.image}.png',
            imgWidth: 229,
            rules: [
              {'content': participateGroup.description},
            ],
            buttonText: '참가하기',
            onPressed: () async {
              final isSuccess =
                  await viewModel.postInvite(participateGroup.shareGroupId);

              if (isSuccess) {
                Navigator.pushNamed(context, '/group');
              } else {
                _showToast(context, '이미 해당 그룹에 참여하였습니다.');
              }
            },
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/templates/index.dart';
import 'package:project_today/screen/read/view_model/read_view_model.dart';
import 'package:project_today/data/repositories/current_group_id_repository.dart'
    as globals;

class ReadView extends StatefulWidget {
  final bool isWeek;

  const ReadView({
    Key? key,
    this.isWeek = false,
  }) : super(key: key); // 생성자에 추가

  @override
  _ReadViewState createState() => _ReadViewState();
}

class _ReadViewState extends State<ReadView> {
  final ReadViewModel _readViewModel = Get.put(ReadViewModel());
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initState에서 context를 사용하면 안되므로 didChangeDependencies에서 처리
    if (!_isInitialized) {
// arguments를 Map으로 받음
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final int? bundleId = args['bundleId'] as int?; // bundleId 추출
        final bool isWeek = args['isWeek'] as bool? ?? false; // isWeek 추출
        final shareGroupId = globals.currentGroupId.value; // RxInt로 접근

        if (bundleId != null) {
          _readViewModel.fetchDiaryData(bundleId, shareGroupId);
        } else {
          print("번들 ID가 없습니다.");
        }

        _isInitialized = true;
      } else {
        print("전달된 인수가 없습니다.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        top: true,
        child: Obx(() {
          if (_readViewModel.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final diaries = _readViewModel.diaries;

          if (diaries.isEmpty) {
            return const Center(child: Text('다이어리 데이터가 없습니다.'));
          }

          // 서버에서 불러온 데이터로 이미지와 날짜 및 사용자 정보 리스트 생성
          final imageUrls =
              diaries.map((diary) => diary.finalDiaryImage).toList();
          final dates = diaries.map((diary) => diary.createdAt).toList();
          final userInfo = diaries.map((diary) {
            return {
              'imgPath': diary.writerProfileImage,
              'name': diary.writerNickname,
              'role': 'USER', // 역할 정보가 없으면 기본값으로 USER 설정
            };
          }).toList();

          return ReadTemplates(
            dates: dates,
            imageUrls: imageUrls,
            userInfo: userInfo,
            showButton: widget.isWeek, // isWeek를 showButton에 전달
            onWriteButtonPressed: () {
              Navigator.pushNamed(context, '/write');
            },
          );
        }),
      ),
    );
  }
}

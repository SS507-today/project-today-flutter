import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/core/constant/colors.dart';
import 'package:project_today/ui/atoms/index.dart';
import 'package:project_today/ui/templates/index.dart';
import 'package:project_today/ui/organisms/index.dart';
import 'package:project_today/screen/read/view_model/read_view_model.dart';
import 'package:project_today/data/repositories/current_group_id_repository.dart'
    as globals;
import 'package:skeletonizer/skeletonizer.dart';

class ReadView extends StatefulWidget {
  const ReadView({Key? key}) : super(key: key);

  @override
  _ReadViewState createState() => _ReadViewState();
}

class _ReadViewState extends State<ReadView> {
  final ReadViewModel _viewModel = Get.put(ReadViewModel());
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
          _viewModel.fetchDiaryData(bundleId, shareGroupId);
        } else {
          print("번들 ID가 없습니다.");
        }

        setState(() {
          _isInitialized = true;
        });
      } else {
        print("전달된 인수가 없습니다.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // isWeek 값을 ModalRoute에서 받아오기
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final bool isWeek = args?['isWeek'] as bool? ?? false; // 전달받은 isWeek 사용

    return Scaffold(
      backgroundColor: ColorSystem.White,
      body: SafeArea(
        top: true,
        child: Obx(() {
          final isLoading = _viewModel.isLoading.value;

          final diaries = _viewModel.diaries;
          //TODO : 서버에 요청해서 isWrited 받아오기
          // 일기 데이터가 없을 때
          if (diaries.isEmpty) {
            return Column(
              children: [
                Header(showBackButton: true),
                Expanded(
                  child: Center(
                    child: Text('아직 다이어리 데이터가 없어요!'),
                  ),
                ),
                if (isWeek) // isWeek가 true일 때만 버튼 표시
                  DefaultActionButton(
                    text: '일기 쓰기',
                    onPressed: () {
                      Navigator.pushNamed(context, '/write');
                    },
                    isActive: true,
                  ),
              ],
            );
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

          return Skeletonizer(
              enabled: isLoading, // 로딩 중일 때 Skeletonizer 활성화
              child: ReadTemplates(
                dates: dates,
                imageUrls: imageUrls,
                userInfo: userInfo,
                showButton: isWeek, // ModalRoute에서 받은 isWeek를 showButton에 전달
                onWriteButtonPressed: () {
                  Navigator.pushNamed(context, '/write');
                },
              ));
        }),
      ),
    );
  }
}

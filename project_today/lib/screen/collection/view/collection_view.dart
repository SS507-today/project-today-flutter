import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_today/screen/collection/view_model/collection_view_model.dart';
import 'package:project_today/ui/organisms/index.dart';

class CollectionView extends StatefulWidget {
  @override
  _CollectionViewState createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  final CollectionViewModel _collectionViewModel =
      Get.put(CollectionViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final bundles = _collectionViewModel.bundlesList;
        /*.length > 1
            ? _collectionViewModel.bundlesList.sublist(1) // 첫 번째 번들 제외
            : [];
*/
        final bundleData = bundles.map((bundle) {
          return {
            'id': bundle.bundleId,
            'imgsrc': _collectionViewModel.coverImage != 0
                ? 'assets/images/cover/group_${_collectionViewModel.coverImage}.png'
                : 'assets/images/temp_bg.png', // 커버 이미지를 번들에 맞게 설정
            'desc': '${bundle.startDate} ~ ${bundle.endDate}',
          };
        }).toList();

        return bundles.isEmpty
            ? Center(child: Text('번들이 없습니다.')) // 번들이 없을 때 대체 메시지
            : ExpandedGridView(
                groupData: bundleData,
                isLoading: isLoading,
              );
      }),
    );
  }
}

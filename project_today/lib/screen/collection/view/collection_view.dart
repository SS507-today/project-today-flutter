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
    return Obx(() {
      final bundles = _collectionViewModel.bundlesList;
      final bundleData = bundles.map((bundle) {
        return {
          'id': bundle.bundleId,
          'imgsrc': _collectionViewModel.coverImage != 0
              ? 'assets/images/cover/group_${_collectionViewModel.coverImage}.png'
              : 'assets/images/temp_bg.png',
          'desc': '${bundle.startDate} ~ ${bundle.endDate}',
        };
      }).toList();

      return Scaffold(
        body: bundles.isEmpty
            ? Center(child: Text('번들이 없습니다.'))
            : Column(
                children: [
                  ExpandedGridView(
                    groupData: bundleData,
                    isLoading: isLoading,
                  ),
                ],
              ),
      );
    });
  }
}

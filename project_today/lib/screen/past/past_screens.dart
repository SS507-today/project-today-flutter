import 'package:flutter/material.dart';
import 'package:project_today/core/constant/index.dart';
import 'package:project_today/screen/collection/collection_screens.dart';
import 'package:project_today/screen/member/member_screens.dart';
import 'package:project_today/ui/organisms/index.dart';
import 'package:project_today/ui/templates/index.dart';

class PastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tabbartemplate(headerTitle: '지난 일기장');
  }
}

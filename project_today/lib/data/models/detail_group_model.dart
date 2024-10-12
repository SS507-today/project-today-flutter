/// 단일 그룹 상세 조회 모델
class DetailGroupModel {
  final String name;
  final int memberCount;
  final String description;
  final int coverImage;
  final String ruleFirst;
  final String ruleSecond;
  final String ruleThird;

  DetailGroupModel({
    required this.name,
    required this.memberCount,
    required this.description,
    required this.coverImage,
    required this.ruleFirst,
    required this.ruleSecond,
    required this.ruleThird,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'memberCount': memberCount,
      'description': description,
      'coverImage': coverImage,
      'ruleFirst': ruleFirst,
      'ruleSecond': ruleSecond,
      'ruleThird': ruleThird,
    };
  }
}

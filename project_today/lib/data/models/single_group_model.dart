/// 단일 그룹 상세 조회 모델
class SingleGroupModel {
  final int shareGroupId; // 그룹 ID
  final String groupName; // 그룹 이름
  final int coverImage; // 커버 이미지
  final String description; // 그룹 설명
  final String ruleFirst; // 첫 번째 규칙
  final String ruleSecond; // 두 번째 규칙
  final String ruleThird; // 세 번째 규칙

  SingleGroupModel({
    required this.shareGroupId,
    required this.groupName,
    required this.coverImage,
    required this.description,
    required this.ruleFirst,
    required this.ruleSecond,
    required this.ruleThird,
  });

  /// JSON 데이터를 SingleGroupModel 객체로 변환하는 팩토리 생성자
  factory SingleGroupModel.fromJson(Map<String, dynamic> json) {
    return SingleGroupModel(
      shareGroupId: json['shareGroupId'],
      groupName: json['groupName'],
      coverImage: json['coverImage'],
      description: json['description'],
      ruleFirst: json['ruleFirst'],
      ruleSecond: json['ruleSecond'],
      ruleThird: json['ruleThird'],
    );
  }

  /// SingleGroupModel 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'shareGroupId': shareGroupId,
      'groupName': groupName,
      'coverImage': coverImage,
      'description': description,
      'ruleFirst': ruleFirst,
      'ruleSecond': ruleSecond,
      'ruleThird': ruleThird,
    };
  }
}

/// 단일 그룹 상세 생성 모델
class DetailGroupModel {
  final String name; // 그룹 이름
  final int memberCount; // 멤버 수
  final String description; // 그룹 설명
  final int coverImage; // 커버 이미지 ID
  final String ruleFirst; // 첫 번째 규칙
  final String ruleSecond; // 두 번째 규칙
  final String ruleThird; // 세 번째 규칙

  DetailGroupModel({
    required this.name,
    required this.memberCount,
    required this.description,
    required this.coverImage,
    required this.ruleFirst,
    required this.ruleSecond,
    required this.ruleThird,
  });

  /// JSON 데이터를 `DetailGroupModel` 객체로 변환하는 팩토리 생성자
  factory DetailGroupModel.fromJson(Map<String, dynamic> json) {
    return DetailGroupModel(
      name: json['name'],
      memberCount: json['memberCount'],
      description: json['description'],
      coverImage: json['coverImage'],
      ruleFirst: json['ruleFirst'],
      ruleSecond: json['ruleSecond'],
      ruleThird: json['ruleThird'],
    );
  }

  /// `DetailGroupModel` 객체를 JSON 형식으로 변환하는 메서드
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

/// 단일 그룹 조회 모델
class Group {
  final int shareGroupId;
  final int coverImage;
  final String status;
  final DateTime createdAt;
  final String groupName;

  Group({
    required this.shareGroupId,
    required this.coverImage,
    required this.status,
    required this.createdAt,
    required this.groupName,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      shareGroupId: json['shareGroupId'],
      coverImage: json['coverImage'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      groupName: json['groupName'],
    );
  }
}

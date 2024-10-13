/// 초대코드로 그룹 조회 모델
class ParticipateGroup {
  final int shareGroupId;
  final String ownerName;
  final int memberCount;
  final String groupName;
  final int image;
  final String description;
  final DateTime createdAt;

  ParticipateGroup({
    required this.shareGroupId,
    required this.ownerName,
    required this.memberCount,
    required this.groupName,
    required this.image,
    required this.description,
    required this.createdAt,
  });

  factory ParticipateGroup.fromJson(Map<String, dynamic> json) {
    return ParticipateGroup(
      shareGroupId: json['shareGroupId'],
      ownerName: json['ownerName'],
      memberCount: json['memberCount'],
      groupName: json['groupName'],
      image: json['image'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

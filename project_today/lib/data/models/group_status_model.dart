//단일 그룹 상태 조회 모델
class GroupStatus {
  final int shareGroupId;
  final String status;
  final DateTime openAt;
  final String name;

  GroupStatus({
    required this.shareGroupId,
    required this.status,
    required this.openAt,
    required this.name,
  });

  factory GroupStatus.fromJson(Map<String, dynamic> json) {
    return GroupStatus(
      shareGroupId: json['shareGroupId'],
      status: json['status'],
      openAt: DateTime.parse(json['openAt']),
      name: json['name'],
    );
  }
}

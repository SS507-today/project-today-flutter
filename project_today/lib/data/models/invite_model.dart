/// shareGroupId로 참여할 그룹 정보 조회 모델
class InviteGroupResponse {
  final int status;
  final String code;
  final String message;
  final InviteGroup? data;

  InviteGroupResponse({
    required this.status,
    required this.code,
    required this.message,
    this.data,
  });

  factory InviteGroupResponse.fromJson(Map<String, dynamic> json) {
    return InviteGroupResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? InviteGroup.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class InviteGroup {
  final int shareGroupId;
  final int profileId;
  final String status;
  final DateTime joinedAt;

  InviteGroup({
    required this.shareGroupId,
    required this.profileId,
    required this.status,
    required this.joinedAt,
  });

  factory InviteGroup.fromJson(Map<String, dynamic> json) {
    return InviteGroup(
      shareGroupId: json['shareGroupId'],
      profileId: json['profileId'],
      status: json['status'],
      joinedAt: DateTime.parse(json['joinedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shareGroupId': shareGroupId,
      'profileId': profileId,
      'status': status,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }
}

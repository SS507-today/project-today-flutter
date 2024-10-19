/// 그룹 프로필 모델 정의
// /profiles/{profileId}, /profiles/profileListInfo, /profiles/my 조회할 때

class GroupProfile {
  /// 공유 그룹 ID
  int shareGroupId;

  /// 프로필 ID
  int profileId;

  /// 프로필 닉네임
  String profileNickName;

  /// 설명
  String description;

  /// 프로필 이미지 URL
  String image;

  /// 역할
  String role;

  /// 가입 일자
  String joinedAt;

  /// 내 차례 여부
  bool myTurn;

  GroupProfile({
    required this.shareGroupId,
    required this.profileId,
    required this.profileNickName,
    required this.description,
    required this.image,
    required this.role,
    required this.joinedAt,
    required this.myTurn,
  });

  /// JSON 데이터를 GroupProfile 객체로 변환하는 팩토리 생성자
  factory GroupProfile.fromJson(Map<String, dynamic> json) {
    return GroupProfile(
      shareGroupId: json['shareGroupId'],
      profileId: json['profileId'],
      profileNickName: json['profileNickName'],
      description: json['description'],
      image: json['image'],
      role: json['role'],
      joinedAt: json['joinedAt'],
      myTurn: json['myTurn'],
    );
  }

  /// GroupProfile 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'shareGroupId': shareGroupId,
      'profileId': profileId,
      'profileNickName': profileNickName,
      'description': description,
      'image': image,
      'role': role,
      'joinedAt': joinedAt,
      'myTurn': myTurn,
    };
  }
}

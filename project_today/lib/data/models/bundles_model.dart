/// 다이어리에 태그된 멤버 목록을 나타내는 모델 클래스
class TaggedMembersModel {
  /// 다이어리 ID
  final int diaryId;

  /// 태그된 멤버들의 리스트
  final List<TaggedMember> taggedMembersList;

  TaggedMembersModel({
    required this.diaryId,
    required this.taggedMembersList,
  });

  /// JSON 데이터를 `TaggedMembersModel` 객체로 변환하는 팩토리 생성자
  factory TaggedMembersModel.fromJson(Map<String, dynamic> json) {
    return TaggedMembersModel(
      diaryId: json['diaryId'], // JSON에서 'diaryId' 값을 가져와 할당
      taggedMembersList: List<TaggedMember>.from(
        json['taggedMembersList'].map(
          (member) => TaggedMember.fromJson(member),
        ),
      ), // JSON에서 'taggedMembersList' 리스트를 변환하여 할당
    );
  }

  /// `TaggedMembersModel` 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'diaryId': diaryId, // 'diaryId' 값을 JSON 필드로 변환
      'taggedMembersList': List<dynamic>.from(
        taggedMembersList.map((member) => member.toJson()),
      ), // 'taggedMembersList'를 JSON 리스트로 변환
    };
  }
}

/// 개별 태그된 멤버를 나타내는 모델 클래스
class TaggedMember {
  /// 프로필 ID
  final int profileId;

  /// 멤버 이름
  final String name;

  /// 멤버 프로필 이미지
  final String image;

  TaggedMember({
    required this.profileId,
    required this.name,
    required this.image,
  });

  /// JSON 데이터를 `TaggedMember` 객체로 변환하는 팩토리 생성자
  factory TaggedMember.fromJson(Map<String, dynamic> json) {
    return TaggedMember(
      profileId: json['profileId'], // JSON에서 'profileId' 값을 가져와 할당
      name: json['name'], // JSON에서 'name' 값을 가져와 할당
      image: json['image'], // JSON에서 'image' 값을 가져와 할당
    );
  }

  /// `TaggedMember` 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId, // 'profileId' 값을 JSON 필드로 변환
      'name': name, // 'name' 값을 JSON 필드로 변환
      'image': image, // 'image' 값을 JSON 필드로 변환
    };
  }
}

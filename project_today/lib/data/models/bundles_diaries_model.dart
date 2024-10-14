/// 특정 번들에 속한 다이어리 목록을 최신순으로 조회하는 모델 클래스
/// '/bundles/$bundleId/diaries?shareGroupId=$shareGroupId' 조회 시 사용
class BundlesDiaries {
  /// 공유 그룹 ID
  final int shareGroupId;

  /// 번들 ID
  final int bundleId;

  /// 다이어리 목록
  final List<Diary> diaries;

  BundlesDiaries({
    required this.shareGroupId,
    required this.bundleId,
    required this.diaries,
  });

  /// JSON 데이터를 BundlesDiaries 객체로 변환하는 팩토리 생성자
  factory BundlesDiaries.fromJson(Map<String, dynamic> json) {
    return BundlesDiaries(
      shareGroupId: json['shareGroupId'],
      bundleId: json['bundleId'],
      diaries: List<Diary>.from(json['diaries'].map((x) => Diary.fromJson(x))),
    );
  }

  /// BundlesDiaries 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'shareGroupId': shareGroupId,
      'bundleId': bundleId,
      'diaries': List<dynamic>.from(diaries.map((x) => x.toJson())),
    };
  }
}

/// 다이어리 정보 모델 클래스 정의
class Diary {
  /// 다이어리 ID
  final int diaryId;

  /// 작성자 프로필 ID
  final int writerProfileId;

  /// 작성자 프로필 이미지 URL
  final String writerProfileImage;

  /// 작성자 닉네임
  final String writerNickname;

  /// 작성자 설명
  final String writerDescription;

  /// 최종 다이어리 이미지 URL
  final String finalDiaryImage;

  /// 다이어리 작성 일자
  final String createdAt;

  Diary({
    required this.diaryId,
    required this.writerProfileId,
    required this.writerProfileImage,
    required this.writerNickname,
    required this.writerDescription,
    required this.finalDiaryImage,
    required this.createdAt,
  });

  /// JSON 데이터를 Diary 객체로 변환하는 팩토리 생성자
  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      diaryId: json['diaryId'],
      writerProfileId: json['writerProfileId'],
      writerProfileImage: json['writerProfileImage'],
      writerNickname: json['writerNickname'],
      writerDescription: json['writerDescription'],
      finalDiaryImage: json['finalDiaryImage'],
      createdAt: json['createdAt'],
    );
  }

  /// Diary 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'diaryId': diaryId,
      'writerProfileId': writerProfileId,
      'writerProfileImage': writerProfileImage,
      'writerNickname': writerNickname,
      'writerDescription': writerDescription,
      'finalDiaryImage': finalDiaryImage,
      'createdAt': createdAt,
    };
  }
}

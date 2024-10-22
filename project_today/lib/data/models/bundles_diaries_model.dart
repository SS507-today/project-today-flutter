// 특정 번들에 속한 다이어리 목록을 최신순으로 조회하는 모델 클래스
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
    var diariesData = json['diaries'];

    List<Diary> diariesList = [];

    if (diariesData is List) {
      // diariesData가 리스트인 경우
      diariesList = diariesData.map((x) {
        print("Parsing individual diary: $x");
        return Diary.fromJson(x as Map<String, dynamic>);
      }).toList();
    } else {
      // diariesData가 리스트가 아닌 경우 예외처리
      print("Unexpected type for 'diaries': ${diariesData.runtimeType}");
    }

    return BundlesDiaries(
      shareGroupId: json['shareGroupId'],
      bundleId: json['bundleId'],
      diaries: diariesList,
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

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      diaryId: json['diaryId'] as int? ?? 0,
      writerProfileId: json['writerProfileId'] as int? ?? 0,
      writerProfileImage: json['writerProfileImage'] as String? ?? '',
      writerNickname: json['writerNickname'] as String? ?? '',
      writerDescription: json['writerDescription'] as String? ?? '',
      finalDiaryImage: json['finalDiaryImage'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'Diary(diaryId: $diaryId, writerProfileId: $writerProfileId, writerProfileImage: $writerProfileImage, writerNickname: $writerNickname, finalDiaryImage: $finalDiaryImage, createdAt: $createdAt)';
  }

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

/// 번들 목록 모델 정의
class BundleModel {
  final int shareGroupId; // 공유 그룹 ID
  final List<BundleInfo> bundleInfoList; // 번들 정보 리스트
  final int coverImage; // 커버 이미지 ID
  final int page; // 페이지 번호
  final int totalElements; // 전체 요소 수
  final bool first; // 첫 번째 페이지 여부
  final bool last; // 마지막 페이지 여부

  BundleModel({
    required this.shareGroupId,
    required this.bundleInfoList,
    required this.coverImage,
    required this.page,
    required this.totalElements,
    required this.first,
    required this.last,
  });

  /// JSON 데이터를 BundleModel 객체로 변환하는 팩토리 생성자
  factory BundleModel.fromJson(Map<String, dynamic> json) {
    return BundleModel(
      shareGroupId: json['shareGroupId'],
      bundleInfoList: List<BundleInfo>.from(
        json['bundleInfoList'].map((x) => BundleInfo.fromJson(x)),
      ),
      coverImage: json['coverImage'],
      page: json['page'],
      totalElements: json['totalElements'],
      first: json['first'],
      last: json['last'],
    );
  }

  /// BundlesModel 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'shareGroupId': shareGroupId,
      'bundleInfoList': List<dynamic>.from(
        bundleInfoList.map((x) => x.toJson()),
      ),
      'coverImage': coverImage,
      'page': page,
      'totalElements': totalElements,
      'first': first,
      'last': last,
    };
  }
}

/// 번들 정보 모델 클래스 정의
class BundleInfo {
  final int bundleId; // 번들 ID
  final String startDate; // 시작 날짜
  final String endDate; // 종료 날짜

  BundleInfo({
    required this.bundleId,
    required this.startDate,
    required this.endDate,
  });

  /// JSON 데이터를 BundleInfo 객체로 변환하는 팩토리 생성자
  factory BundleInfo.fromJson(Map<String, dynamic> json) {
    return BundleInfo(
      bundleId: json['bundleId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  /// BundleInfo 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'bundleId': bundleId,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

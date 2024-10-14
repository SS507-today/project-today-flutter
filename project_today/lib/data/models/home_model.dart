/// 그룹 홈에서 정의되는 모델
class HomeResponse {
  /// 내 차례인지
  final bool? myTurn;

  /// 내 차례 맞으면 반환되는 그룹 정보
  final HomeGroupDetailInfo? shareGroupDetailInfo;

  /// 내 차례 아니면 반환되는 현재 작성중인 사람
  final CurrentWriter? currentWriter;

  HomeResponse({
    this.myTurn,
    this.shareGroupDetailInfo,
    this.currentWriter,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      myTurn: json['myTurn'] as bool?,
      shareGroupDetailInfo: json['shareGroupDetailInfo'] != null
          ? HomeGroupDetailInfo.fromJson(json['shareGroupDetailInfo'])
          : null,
      currentWriter: json['currentWriter'] != null
          ? CurrentWriter.fromJson(json['currentWriter'])
          : null,
    );
  }
}

/// 내 차례 맞으면 반환되는 그룹 정보
class HomeGroupDetailInfo {
  final int shareGroupId;
  final String groupName;
  final int coverImage;
  final String description;
  final String ruleFirst;
  final String ruleSecond;
  final String ruleThird;

  HomeGroupDetailInfo({
    required this.shareGroupId,
    required this.groupName,
    required this.coverImage,
    required this.description,
    required this.ruleFirst,
    required this.ruleSecond,
    required this.ruleThird,
  });

  factory HomeGroupDetailInfo.fromJson(Map<String, dynamic> json) {
    return HomeGroupDetailInfo(
      shareGroupId: json['shareGroupId'],
      groupName: json['groupName'],
      coverImage: json['coverImage'],
      description: json['description'],
      ruleFirst: json['ruleFirst'],
      ruleSecond: json['ruleSecond'],
      ruleThird: json['ruleThird'],
    );
  }
}

/// 내 차례 아니면 반환되는 현재 작성중인 사람
class CurrentWriter {
  final int profileId;
  final String name;
  final String description;
  final String image;

  CurrentWriter({
    required this.profileId,
    required this.name,
    required this.description,
    required this.image,
  });

  factory CurrentWriter.fromJson(Map<String, dynamic> json) {
    return CurrentWriter(
      profileId: json['profileId'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}

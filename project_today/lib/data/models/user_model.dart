/// 사용자 모델 정의
class User {
  final int authId; // 사용자 고유 ID
  final String email; // 이메일
  final String image; // 프로필 이미지 URL
  final String platform; // 플랫폼 정보 (e.g., kakao)
  final String refreshToken; // 리프레시 토큰
  final String name; // 사용자 이름
  String nickname; // final 제거하여 수정 가능하도록 변경

  User({
    required this.authId,
    required this.email,
    required this.image,
    required this.platform,
    required this.refreshToken,
    required this.name,
    required this.nickname,
  });

  /// JSON 데이터를 User 객체로 변환하는 팩토리 생성자
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      authId: json['authId'],
      email: json['email'],
      image: json['image'],
      platform: json['platform'],
      refreshToken: json['refreshToken'],
      name: json['name'],
      nickname: json['nickname'],
    );
  }

  /// User 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'authId': authId,
      'email': email,
      'image': image,
      'platform': platform,
      'refreshToken': refreshToken,
      'name': name,
      'nickname': nickname,
    };
  }
}

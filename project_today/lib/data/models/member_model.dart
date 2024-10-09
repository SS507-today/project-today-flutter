/// 유저 모델 정의
class Member {
  final int id;
  final String name;
  final String username;
  final String email;

  Member({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}

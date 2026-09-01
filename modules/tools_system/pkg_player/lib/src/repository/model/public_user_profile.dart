class PublicUserProfile {
  final int userId;
  final String nickname;
  final String? avatar;
  final String? signature;

  const PublicUserProfile({
    required this.userId,
    required this.nickname,
    this.avatar,
    this.signature,
  });

  factory PublicUserProfile.fromJson(Map<String, dynamic> json) {
    return PublicUserProfile(
      userId: json['user_id'] as int,
      nickname: json['nickname'] as String,
      avatar: json['avatar'] as String?,
      signature: json['signature'] as String?,
    );
  }
}

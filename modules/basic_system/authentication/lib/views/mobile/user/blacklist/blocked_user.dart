/// 黑名单页面展示的用户公开资料。
class BlockedUser {
  const BlockedUser({
    required this.userId,
    required this.nickname,
    required this.avatar,
    required this.signature,
    required this.createdAt,
  });

  final int userId;
  final String nickname;
  final String? avatar;
  final String? signature;
  final DateTime? createdAt;

  factory BlockedUser.fromJson(Map<String, dynamic> json) {
    return BlockedUser(
      userId: json['user_id'] as int,
      nickname: json['nickname'] as String,
      avatar: json['avatar'] as String?,
      signature: json['signature'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }
}

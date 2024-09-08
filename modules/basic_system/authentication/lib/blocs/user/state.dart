

class UserPerformance {
  final String username;
  final int userId;
  final String phone;
  final String email;
  final int emailVerified;
  final String weiChat;
  final String avatar;


  String get showEmail {
    String prefix = email.split('@')[0];
    String tail = email.split('@')[1];
    String result = '';
    if (prefix.length > 8) {
      result =
      "${prefix.substring(0, 3)}***${prefix.substring(prefix.length - 2)}";
    } else {
      result = prefix;
    }
    return '$result@$tail';
  }

  String get showPhone =>
      "${phone.substring(0, 3)}***${phone.substring(phone.length - 4)}";

  UserPerformance({
    required this.username,
    required this.userId,
    required this.email,
    required this.emailVerified,
    required this.weiChat,
    required this.phone,
    required this.avatar,
  });

  UserPerformance copyWith({
    String? username,
    int? userId,
    String? phone,
    String? avatar,
    String? email,
    int? emailVerified,
    String? weiChat,
    bool? hasPwd,
    int? pollenCoin,
    int? honeyCoin,
  }) =>
      UserPerformance(
        weiChat: weiChat ?? this.weiChat,
        username: username ?? this.username,
        userId: userId ?? this.userId,
        phone: phone ?? this.phone,
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        emailVerified: emailVerified ?? this.emailVerified,
      );

  static UserPerformance fromJson(Map<String, dynamic> map) => UserPerformance(
      username: map["username"] ?? '',
      userId: map["userId"] ?? 0,
      phone: map["phone"] ?? '',
      avatar: map["avatar"] ?? '',
      email: map["email"] ?? '',
      weiChat: map["weiChat"] ?? '',
      emailVerified: map["emailVerified"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "userId": userId,
    "phone": phone,
    "avatar": avatar,
    "weiChat": weiChat,
    "email": email,
    "emailVerified": emailVerified,
  };


}
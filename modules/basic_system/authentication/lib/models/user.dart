import 'package:equatable/equatable.dart';

/// create by 张风捷特烈 on 2021/1/17
/// contact me by email 1981462002@qq.com
/// 说明:

//        "userId": 1302422300380954625,
//         "username": "toly",
//         "email": "1981462001@qq.com",
//         "activeCode": 1,
//         "roles": "admin",
//         "createAt": "2020-09-06T01:44:09.000+00:00",
//         "updateAt": "2020-12-12T06:35:22.000+00:00"

class User extends Equatable {
  final String username;
  final String userAvatar;
  final String email;
  final String roles;
  final int userId;

  const User({
    required this.username,
    required this.email,
    required this.roles,
    required this.userId,
    required this.userAvatar,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      roles: map['roles'],
      userId: map['userId'],
      userAvatar: map['userAvatar'],
    );
  }

  bool get isHonour => roles.contains('honour');

  @override
  List<Object> get props => [username, email, roles, userId, userAvatar];

  Map toJson() => {
        "username": username,
        "email": email,
        "roles": roles,
        "userId": userId,
        "userAvatar": userAvatar,
      };
}

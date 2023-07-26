import 'package:utils/utils.dart';

import '../models/user.dart';

abstract class AuthRepository {

  // 用户登录接口
  Future<TaskResult<User>> login({
    required String username,
    required String password,
  });

  // 用户注册接口
  // 邮箱注册
  Future<TaskResult<bool>> register({
    required String email,
    required String code,
  });

  // 发送邮箱验证信息
  Future<TaskResult<String>> sendEmail({
    required String email,
  });
}

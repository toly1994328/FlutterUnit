import 'package:authentication/models/user.dart';

import 'package:utils/src/http_utils/task_result.dart';
import 'package:utils/utils.dart';

import '../auth_repository.dart';

const String kSendEmail = '/sendEmail/';
const String kLogin = '/login';
const String kRegister = '/register';

class HttpAuthRepository implements AuthRepository {
  @override
  Future<TaskResult<User>> login({
    required String username,
    required String password,
  }) async {
    String errorMsg = "";

    try {
      var result = await HttpUtil.instance.client.post(
        kLogin,
        data: {
          "username": username,
          "password": password,
        },
      );

      if (result.data != null) {
        if (result.data['status']) {
          return TaskResult<User>(
            msg: result.data['msg'],
            data: User.fromJson(result.data['data']),
            success: result.data['status'],
          );
        } else {
          return TaskResult<User>(
            msg: result.data['msg'],
            data: null,
            success: false,
          );
        }
      }
    } catch (e) {
      errorMsg = e.toString();
    }

    return TaskResult.error(msg: '请求错误: $errorMsg');
  }

  @override
  Future<TaskResult<bool>> register({
    required String email,
    required String code,
  }) async {
    String errorMsg = "";

    try {
      var result = await HttpUtil.instance.client
          .post(kRegister, data: {"email": email, "activeCode": code});

      if (result.data != null) {
        return TaskResult.success(data: result.data);
      }
    } catch (e) {
      errorMsg = e.toString();
    }

    return TaskResult.error(msg: '请求错误: $errorMsg');
  }

  @override
  Future<TaskResult<String>> sendEmail({required String email}) async {
    try {
      var result = await HttpUtil.instance.client.post(kSendEmail + email);
      if (result.data != null) {
        if(result.data['status']){
          return TaskResult.success(data: result.data);
        }else{
          return TaskResult.error(msg: result.data['msg']);
        }
      }
    } catch (e) {
      print(e);
    }
    return const TaskResult.error(msg: '请求错误');
  }
}

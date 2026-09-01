import 'package:flutter/widgets.dart';

/// 请求宿主打开登录流程。
typedef LoginRequiredCallback = Future<void> Function(BuildContext context);

/// 插件模块由宿主注入的认证能力。
class PkgPlayerConfig {
  /// 当前用户是否已经登录。
  final bool isAuthenticated;

  /// 未登录用户尝试评论时由宿主处理的登录动作。
  final LoginRequiredCallback onLoginRequired;

  const PkgPlayerConfig({
    required this.isAuthenticated,
    required this.onLoginRequired,
  });
}

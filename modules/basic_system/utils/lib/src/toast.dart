import 'package:flutter/material.dart';
import 'package:fx_ability/fx_ability.dart';

/// 旧 Toast 调用的兼容入口，新代码应直接使用 `FxAbility().toast`。
abstract final class Toast {
  /// 通过全局 Ability 显示普通提示。
  static void toast(
    BuildContext _,
    String msg, {
    Duration duration = const Duration(milliseconds: 600),
    Color? color,
    SnackBarAction? action,
  }) {
    FxAbility().toast.show(
          msg,
          duration: duration,
          backgroundColor: color,
          action: action == null
              ? null
              : ToastAction(
                  label: action.label,
                  onPressed: action.onPressed,
                  textColor: action.textColor,
                ),
        );
  }

  /// 通过全局 Ability 显示错误提示。
  static void error(BuildContext _, String msg) {
    FxAbility().toast.error(msg);
  }

  /// 通过全局 Ability 显示警告提示。
  static void warning(BuildContext _, String msg) {
    FxAbility().toast.warning(msg);
  }

  /// 通过全局 Ability 显示成功提示。
  static void success(BuildContext _, String msg) {
    FxAbility().toast.success(msg);
  }

  /// 通过全局 Ability 显示绿色成功提示。
  static void green(BuildContext _, String msg) {
    FxAbility().toast.show(msg, backgroundColor: Colors.green);
  }
}

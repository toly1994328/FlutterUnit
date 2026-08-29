import 'package:flutter/material.dart';
import 'package:fx_ability/fx_ability.dart';
import 'package:tolyui_message/tolyui_message.dart';

/// FlutterUnit 全局 Toast 使用的 ScaffoldMessenger 入口。
final GlobalKey<ScaffoldMessengerState> flutterUnitScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

/// 注册 FlutterUnit 提供的宿主能力。
void registerFlutterUnitAbilities() {
  FxAbility().registerToast(FlutterUnitToast());
}

/// 基于 TolyUI Message 的 FlutterUnit Toast 实现。
class FlutterUnitToast extends Toastable {
  @override
  void show(
    String message, {
    Duration? duration,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    ToastAction? action,
  }) {
    $message.info(
      message: action == null ? message : null,
      richMessage: action == null
          ? null
          : _buildActionMessage(
              message: message,
              textColor: textColor,
              fontSize: fontSize,
              action: action,
            ),
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  @override
  void success(
    String message, {
    Duration? duration,
    Color? textColor,
    double? fontSize,
  }) {
    $message.success(message: message, duration: duration);
  }

  @override
  void error(
    String message, {
    Duration? duration,
    Color? textColor,
    double? fontSize,
  }) {
    $message.error(message: message, duration: duration);
  }

  @override
  void warning(
    String message, {
    Duration? duration,
    Color? textColor,
    double? fontSize,
  }) {
    $message.warning(message: message, duration: duration);
  }

  @override
  void info(
    String message, {
    Duration? duration,
    Color? textColor,
    double? fontSize,
  }) {
    $message.info(message: message, duration: duration);
  }

  /// 构建兼容旧 Toast 操作按钮的富文本消息。
  InlineSpan _buildActionMessage({
    required String message,
    required ToastAction action,
    Color? textColor,
    double? fontSize,
  }) {
    return TextSpan(
      style: TextStyle(color: textColor, fontSize: fontSize),
      children: [
        TextSpan(text: message),
        const WidgetSpan(child: SizedBox(width: 8)),
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: TextButton(
            onPressed: action.onPressed,
            style: TextButton.styleFrom(
              foregroundColor: action.textColor,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(action.label),
          ),
        ),
      ],
    );
  }
}

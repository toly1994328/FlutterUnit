import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:unit_env/unit_env.dart';

/// 订阅当前用户会话并渲染头像的统一入口。
class SessionUserAvatar extends StatelessWidget {
  const SessionUserAvatar({
    super.key,
    required this.size,
    this.guestSource = 'assets/images/guest_avatar.webp',
    this.showBorder = false,
    this.borderColor,
    this.showShadow = true,
    this.cornerRadius,
  });

  /// 头像的逻辑尺寸。
  final double size;

  /// 未登录、无头像或头像加载失败时展示的资源。
  final String guestSource;

  /// 是否显示与 ViewX 一致的头像边框和阴影。
  final bool showBorder;

  /// 自定义头像边框颜色。
  final Color? borderColor;

  /// 是否显示头像阴影。
  final bool showShadow;

  /// 头像圆角，为空时保持圆形。
  final double? cornerRadius;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FxUserSessionCubit, FxUserSession>(
      buildWhen: (previous, current) =>
          _resolveAvatar(previous) != _resolveAvatar(current) ||
          _resolveDisplayName(previous) != _resolveDisplayName(current),
      builder: _buildAvatar,
    );
  }

  Widget _buildAvatar(BuildContext context, FxUserSession session) {
    if (session is! FxAuthed) {
      return UserAvatar(
        source: guestSource,
        radius: size / 2,
        cornerRadius: cornerRadius,
        showBorder: showBorder,
        borderColor: borderColor,
        showShadow: showShadow,
      );
    }
    return UserAvatar(
      displayName: session.user.displayName ?? session.user.id,
      source: _resolveAvatar(session),
      radius: size / 2,
      cornerRadius: cornerRadius,
      showBorder: showBorder,
      borderColor: borderColor,
      showShadow: showShadow,
    );
  }

  String _resolveAvatar(FxUserSession session) {
    if (session is! FxAuthed ||
        session.user.avatar == null ||
        session.user.avatar.toString().trim().isEmpty) {
      return '';
    }
    final String source = session.user.avatar.toString();
    if (Identicon.isIdenticon(source)) return source;
    final int imageSize = (size * 2).round();
    return FlutterUnitHost.resolveImageResource(
      source,
      width: imageSize,
      height: imageSize,
    ).toString();
  }

  String? _resolveDisplayName(FxUserSession session) {
    if (session is! FxAuthed) return null;
    return session.user.displayName ?? session.user.id;
  }
}

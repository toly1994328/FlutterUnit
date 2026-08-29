import 'package:flutter/material.dart';

import 'identicon.dart';
import 'image_render.dart';

/// 与用户业务模型无关的通用头像组件。
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.displayName,
    this.source,
    this.localImagePath,
    this.radius = 30,
    this.cornerRadius,
    this.showBorder = false,
    this.borderWidth = 2,
    this.borderColor,
    this.showShadow = true,
  });

  /// 用于无图占位的公开显示名称。
  final String? displayName;

  /// 网络、资产、本机文件或 Identicon 头像地址。
  final String? source;

  /// 编辑期间优先展示的本机预览路径。
  final String? localImagePath;

  /// 头像半径。
  final double radius;

  /// 头像圆角，为空时保持圆形。
  final double? cornerRadius;

  /// 是否显示头像边框和阴影。
  final bool showBorder;

  /// 头像边框宽度。
  final double borderWidth;

  /// 头像边框颜色；为空时跟随当前主题。
  final Color? borderColor;

  /// 是否显示头像阴影。
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final Widget content = _buildContent(context);
    if (!showBorder) return content;
    return _buildBorder(context, content);
  }

  Widget _buildContent(BuildContext context) {
    final double size = radius * 2;
    final double effectiveRadius = cornerRadius ?? radius;
    final BorderRadius borderRadius = BorderRadius.circular(effectiveRadius);
    if (Identicon.isIdenticon(source)) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Identicon.tryParse(source, size: size) ??
            _buildPlaceholder(context, borderRadius),
      );
    }
    final String? effectiveSource = _effectiveSource;
    if (effectiveSource == null) {
      return _buildPlaceholder(context, borderRadius);
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: ImageRender(
        source: effectiveSource,
        width: size,
        height: size,
        fit: BoxFit.cover,
        cacheWidth: (size * 2).round(),
        cacheHeight: (size * 2).round(),
        errorBuilder: (BuildContext context, Object error) =>
            _buildPlaceholder(context, borderRadius),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context, BorderRadius borderRadius) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: borderRadius,
      ),
      alignment: Alignment.center,
      child: Text(
        _initial,
        style: TextStyle(
          color: colors.onPrimaryContainer,
          fontSize: radius * 0.7,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBorder(BuildContext context, Widget avatar) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ??
              (isDark
                  ? Colors.white.withValues(alpha: 0.2)
                  : theme.colorScheme.primary.withValues(alpha: 0.15)),
          width: borderWidth,
        ),
        boxShadow: showShadow
            ? <BoxShadow>[
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.5)
                      : theme.colorScheme.primary.withValues(alpha: 0.18),
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: avatar,
    );
  }

  String? get _effectiveSource {
    final String local = localImagePath?.trim() ?? '';
    if (local.isNotEmpty) return local;
    final String avatar = source?.trim() ?? '';
    return avatar.isEmpty ? null : avatar;
  }

  String get _initial {
    final String name = displayName?.trim() ?? '';
    return name.isEmpty ? '?' : name.characters.first.toUpperCase();
  }
}

import 'package:flutter/material.dart';
import 'package:unit_env/unit_env.dart';

class CommentAvatar extends StatelessWidget {
  /// 头像资源地址，支持服务端相对路径和完整网络地址。
  final String? avatar;

  /// 用于生成文字占位头像的用户名。
  final String name;

  /// 头像的宽高。
  final double size;

  const CommentAvatar({
    super.key,
    required this.avatar,
    required this.name,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final String? source = avatar?.trim();
    if (source == null || source.isEmpty) {
      return _buildFallback();
    }
    final String imageUrl = FlutterUnitHost.resolveImageResource(
      source,
      width: (size * MediaQuery.devicePixelRatioOf(context)).round(),
    ).toString();
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallback(),
      ),
    );
  }

  Widget _buildFallback() {
    final Color color = _avatarColor(name);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.8), color],
        ),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        name.isEmpty ? 'U' : name[0].toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

Color _avatarColor(String name) {
  const List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
  ];
  return colors[name.hashCode.abs() % colors.length];
}

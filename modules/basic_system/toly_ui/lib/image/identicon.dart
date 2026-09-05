import 'dart:math';

import 'package:flutter/material.dart';

/// 根据稳定种子生成对称图案的头像。
class Identicon extends StatelessWidget {
  const Identicon({
    super.key,
    required this.seed,
    required this.size,
    this.color,
    this.backgroundColor = const Color(0xfff0f0f0),
    this.gridSize = 5,
  });

  /// 用于生成图案的稳定种子。
  final String seed;

  /// 头像逻辑尺寸。
  final double size;

  /// 图案颜色，为空时根据种子生成。
  final Color? color;

  /// 图案背景色。
  final Color backgroundColor;

  /// 图案网格边长。
  final int gridSize;

  /// 判断头像字符串是否使用 Identicon 协议。
  static bool isIdenticon(String? source) {
    return source != null && source.startsWith('identicon:');
  }

  /// 解析 `identicon:<seed>[:<colorHex>]` 格式的头像。
  static Identicon? tryParse(String? source, {required double size}) {
    if (!isIdenticon(source)) return null;
    final String content = source!.substring('identicon:'.length);
    final List<String> parts = content.split(':');
    if (parts.isEmpty || parts.first.isEmpty) return null;
    return Identicon(
      seed: parts.first,
      size: size,
      color: _parseColor(parts.length > 1 ? parts[1] : null),
    );
  }

  static Color? _parseColor(String? source) {
    final String hex = source?.replaceFirst('#', '') ?? '';
    if (hex.length != 6) return null;
    final int? value = int.tryParse(hex, radix: 16);
    return value == null ? null : Color(0xff000000 | value);
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? _generateColor(seed);
    return CustomPaint(
      size: Size.square(size),
      painter: _IdenticonPainter(
        seed: seed,
        color: effectiveColor,
        backgroundColor: backgroundColor,
        gridSize: gridSize,
      ),
    );
  }

  static Color _generateColor(String seed) {
    final int hash = _hashCode(seed);
    final double hue = ((hash * 137) % 360).toDouble();
    final double saturation = 0.5 + ((hash >> 8) % 30) / 100;
    final double lightness = 0.4 + ((hash >> 16) % 20) / 100;
    return HSLColor.fromAHSL(1, hue, saturation, lightness).toColor();
  }

  static int _hashCode(String source) {
    int hash = 5381;
    for (int index = 0; index < source.length; index++) {
      hash = ((hash << 5) + hash) ^ source.codeUnitAt(index);
    }
    return hash.abs();
  }
}

class _IdenticonPainter extends CustomPainter {
  const _IdenticonPainter({
    required this.seed,
    required this.color,
    required this.backgroundColor,
    required this.gridSize,
  });

  /// 图案生成种子。
  final String seed;

  /// 图案颜色。
  final Color color;

  /// 背景颜色。
  final Color backgroundColor;

  /// 网格边长。
  final int gridSize;

  /// 格点图案相对画布单边的留白比例。
  static const double _paddingFactor = 0.24;

  @override
  void paint(Canvas canvas, Size size) {
    final double padding = size.width * _paddingFactor;
    final double cellSize = (size.width - padding * 2) / gridSize;
    final List<List<bool>> pattern = _generatePattern();
    canvas.drawRect(Offset.zero & size, Paint()..color = backgroundColor);
    final Paint paint = Paint()..color = color;
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        if (!pattern[y][x]) continue;
        canvas.drawRect(
          Rect.fromLTWH(
            padding + x * cellSize - 0.5,
            padding + y * cellSize - 0.5,
            cellSize + 1,
            cellSize + 1,
          ),
          paint,
        );
      }
    }
  }

  List<List<bool>> _generatePattern() {
    final Random random = Random(Identicon._hashCode(seed));
    final int halfColumns = (gridSize + 1) ~/ 2;
    final List<List<bool>> pattern = List<List<bool>>.generate(
      gridSize,
      (_) => List<bool>.filled(gridSize, false),
    );
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < halfColumns; x++) {
        final bool filled = random.nextBool();
        pattern[y][x] = filled;
        pattern[y][gridSize - 1 - x] = filled;
      }
    }
    return pattern;
  }

  @override
  bool shouldRepaint(covariant _IdenticonPainter oldDelegate) {
    return seed != oldDelegate.seed ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor ||
        gridSize != oldDelegate.gridSize;
  }
}

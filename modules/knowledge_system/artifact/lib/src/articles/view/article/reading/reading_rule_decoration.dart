import 'package:flutter/material.dart';

/// 分割线在独立留白区居中绘制，避免默认边框紧贴内容。
class ReadingRuleDecoration extends Decoration {
  /// 随阅读主题变化的细线颜色。
  final Color color;
  const ReadingRuleDecoration({required this.color});

  @override
  EdgeInsetsGeometry get padding => const EdgeInsets.symmetric(vertical: 8);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _ReadingRulePainter(color, onChanged);
}

class _ReadingRulePainter extends BoxPainter {
  /// 线条颜色，头尾使用透明渐变收束。
  final Color color;
  _ReadingRulePainter(this.color, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Size? size = configuration.size;
    if (size == null || size.width <= 0) return;
    final Rect rect = offset & size;
    final Paint paint = Paint()
      ..strokeWidth = .75
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(colors: <Color>[
        color.withValues(alpha: 0),
        color,
        color,
        color.withValues(alpha: 0),
      ], stops: const <double>[
        0,
        .08,
        .92,
        1
      ]).createShader(rect);
    final double y = offset.dy + size.height / 2;
    canvas.drawLine(
        Offset(offset.dx, y), Offset(offset.dx + size.width, y), paint);
  }
}

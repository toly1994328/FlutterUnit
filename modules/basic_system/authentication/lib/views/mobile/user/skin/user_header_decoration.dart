import 'package:flutter/material.dart';

/// 用户主页头部下沿的主题化装饰带。
class UserHeaderDecoration extends StatelessWidget {
  const UserHeaderDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomPaint(
      painter: _HeaderDecorationPainter(
        isDark: theme.brightness == Brightness.dark,
        accentColor: theme.colorScheme.primary,
      ),
      child: const SizedBox.expand(),
    );
  }
}

/// 绘制渐变填充、倾斜色面和右侧低对比度纹理。
class _HeaderDecorationPainter extends CustomPainter {
  /// 是否使用暗色背景。
  final bool isDark;

  /// 跟随主题变化的纹理强调色。
  final Color accentColor;

  const _HeaderDecorationPainter({
    required this.isDark,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;
    final Color baseColor =
        isDark ? const Color(0xff202329) : const Color(0xffFAFAFC);
    final Paint backgroundPaint = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          baseColor,
          Color.alphaBlend(
            accentColor.withValues(alpha: isDark ? 0.08 : 0.045),
            baseColor,
          ),
          baseColor,
        ],
        stops: const <double>[0, 0.72, 1],
      ).createShader(bounds);
    canvas.drawRect(bounds, backgroundPaint);

    final Paint dividerPaint = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Colors.transparent,
          accentColor.withValues(alpha: isDark ? 0.32 : 0.2),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, 1))
      ..strokeWidth = 1;
    canvas.drawLine(Offset.zero, Offset(size.width, 0), dividerPaint);

    final Path leadingPlane = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.18, 0)
      ..lineTo(size.width * 0.1, size.height)
      ..lineTo(0, size.height)
      ..close();
    final Paint leadingPlanePaint = Paint()
      ..color = accentColor.withValues(alpha: isDark ? 0.1 : 0.055);
    canvas.drawPath(leadingPlane, leadingPlanePaint);

    final Path rearPlane = Path()
      ..moveTo(size.width * 0.7, 0)
      ..lineTo(size.width * 0.84, 0)
      ..lineTo(size.width * 0.76, size.height)
      ..lineTo(size.width * 0.62, size.height)
      ..close();
    final Paint rearPlanePaint = Paint()
      ..color = accentColor.withValues(alpha: isDark ? 0.1 : 0.05);
    canvas.drawPath(rearPlane, rearPlanePaint);

    final Path frontPlane = Path()
      ..moveTo(size.width * 0.88, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.79, size.height)
      ..close();
    final Paint frontPlanePaint = Paint()
      ..color = accentColor.withValues(alpha: isDark ? 0.15 : 0.075);
    canvas.drawPath(frontPlane, frontPlanePaint);

    final Paint stripePaint = Paint()
      ..color = accentColor.withValues(alpha: isDark ? 0.12 : 0.065)
      ..strokeWidth = 1;
    const double spacing = 16;
    final double stripeStart = size.width * 0.16;
    for (double x = stripeStart; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        stripePaint,
      );
    }
  }

  @override
  bool shouldRepaint(_HeaderDecorationPainter oldDelegate) {
    return oldDelegate.isDark != isDark ||
        oldDelegate.accentColor != accentColor;
  }
}

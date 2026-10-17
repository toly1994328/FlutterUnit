import 'package:flutter/material.dart';

/// 加载区域共用柔和呼吸效果，关闭动画或离屏时停止计时。
class SkeletonLoading extends StatefulWidget {
  /// 当前加载区域的无障碍说明。
  final String label;

  /// 与真实内容形状一致的占位布局。
  final Widget child;
  const SkeletonLoading({super.key, required this.label, required this.child});
  @override
  State<SkeletonLoading> createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading>
    with SingleTickerProviderStateMixin {
  /// 每个加载区域共享一个透明度动画，不逐块创建控制器。
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1100));

  /// 保留可辨认的底色，避免呼吸过程闪成空白。
  late final Animation<double> _opacity = Tween<double>(begin: .55, end: 1)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bool animate = !MediaQuery.disableAnimationsOf(context) &&
        TickerMode.valuesOf(context).enabled;
    if (animate && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!animate) {
      _controller.stop();
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
      container: true,
      liveRegion: true,
      label: widget.label,
      child: ExcludeSemantics(
          child: IgnorePointer(
              child: FadeTransition(
                  opacity: _opacity,
                  child: RepaintBoundary(child: widget.child)))));
}

/// 不依赖伪造文本的圆角占位块，颜色随深浅主题变化。
class SkeletonBlock extends StatelessWidget {
  /// 不指定时占满父级提供的宽度。
  final double? width;

  /// 占位内容的高度。
  final double height;

  /// 图片与文字可分别指定圆角。
  final double radius;
  const SkeletonBlock(
      {super.key, this.width, this.height = 12, this.radius = 6});
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: colors.onSurface.withValues(
                    alpha: colors.brightness == Brightness.dark ? .12 : .07),
                borderRadius: BorderRadius.circular(radius))));
  }
}

import 'package:flutter/material.dart';

/// Expanded 填满 Row 剩余空间。
class ExpandedFillDemo extends StatelessWidget {
  const ExpandedFillDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DemoCanvas(
      child: Row(
        children: <Widget>[
          _ColorBlock(label: '固定 120', width: 120, color: Color(0xff91caff)),
          SizedBox(width: 8),
          Expanded(
            child: _ColorBlock(
                label: 'Expanded\n填满剩余空间', color: Color(0xff95de64)),
          ),
        ],
      ),
    );
  }
}

/// 可交互调整两个 Expanded 的 flex 比例。
class FlexRatioDemo extends StatefulWidget {
  const FlexRatioDemo({super.key});

  @override
  State<FlexRatioDemo> createState() => _FlexRatioDemoState();
}

class _FlexRatioDemoState extends State<FlexRatioDemo> {
  /// 左侧区域的 flex 值。
  int _leftFlex = 1;

  /// 右侧区域的 flex 值。
  int _rightFlex = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _DemoCanvas(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: _leftFlex,
                  child: _ColorBlock(
                    label: 'flex: $_leftFlex',
                    color: const Color(0xff91caff),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: _rightFlex,
                  child: _ColorBlock(
                    label: 'flex: $_rightFlex',
                    color: const Color(0xffffd666),
                  ),
                ),
              ],
            ),
          ),
        ),
        _FlexSlider(
          label: '左侧 flex',
          value: _leftFlex,
          onChanged: _changeLeftFlex,
        ),
        _FlexSlider(
          label: '右侧 flex',
          value: _rightFlex,
          onChanged: _changeRightFlex,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _changeLeftFlex(double value) {
    setState(() => _leftFlex = value.round());
  }

  void _changeRightFlex(double value) {
    setState(() => _rightFlex = value.round());
  }
}

/// 对比 Flexible 的 tight 与 loose 适配方式。
class FlexibleFitDemo extends StatefulWidget {
  const FlexibleFitDemo({super.key});

  @override
  State<FlexibleFitDemo> createState() => _FlexibleFitDemoState();
}

class _FlexibleFitDemoState extends State<FlexibleFitDemo> {
  /// 当前 Flexible 适配方式。
  FlexFit _fit = FlexFit.loose;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _DemoCanvas(
            child: Row(
              children: <Widget>[
                Flexible(
                  fit: _fit,
                  child: const _ColorBlock(
                    label: '子组件期望宽度 140',
                    width: 140,
                    color: Color(0xffb7eb8f),
                  ),
                ),
                const SizedBox(width: 8),
                const _ColorBlock(
                  label: '固定 100',
                  width: 100,
                  color: Color(0xffffccc7),
                ),
              ],
            ),
          ),
        ),
        SegmentedButton<FlexFit>(
          segments: const <ButtonSegment<FlexFit>>[
            ButtonSegment<FlexFit>(value: FlexFit.loose, label: Text('loose')),
            ButtonSegment<FlexFit>(value: FlexFit.tight, label: Text('tight')),
          ],
          selected: <FlexFit>{_fit},
          onSelectionChanged: _changeFit,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _changeFit(Set<FlexFit> values) {
    setState(() => _fit = values.first);
  }
}

/// Spacer 将剩余空间转化为不可见弹性间隔。
class SpacerDemo extends StatelessWidget {
  const SpacerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DemoCanvas(
      child: Row(
        children: <Widget>[
          _ColorBlock(label: '开始', width: 90, color: Color(0xff91caff)),
          Spacer(),
          Text('Spacer 占据中间空间', style: TextStyle(color: Colors.grey)),
          Spacer(flex: 2),
          _ColorBlock(label: '结束', width: 90, color: Color(0xffffd666)),
        ],
      ),
    );
  }
}

/// 对比固定宽度组合与弹性布局方案。
class FlexOverflowSolutionDemo extends StatelessWidget {
  const FlexOverflowSolutionDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return _DemoCanvas(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildExample(
            context,
            title: '固定宽度：窗口变窄时容易溢出',
            child: const Row(
              children: <Widget>[
                _ColorBlock(label: '240', width: 240, color: Color(0xffffccc7)),
                SizedBox(width: 8),
                Flexible(
                    child: Text('剩余内容被迫压缩', overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildExample(
            context,
            title: 'Expanded：先保留尾部，再分配剩余空间',
            child: const Row(
              children: <Widget>[
                Expanded(
                  child: _ColorBlock(label: '自适应内容', color: Color(0xffb7eb8f)),
                ),
                SizedBox(width: 8),
                _ColorBlock(
                    label: '固定 100', width: 100, color: Color(0xff91caff)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExample(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        SizedBox(height: 72, child: child),
      ],
    );
  }
}

class _FlexSlider extends StatelessWidget {
  const _FlexSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  /// 属性名称。
  final String label;

  /// 当前 flex 值。
  final int value;

  /// flex 变化回调。
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 20),
        SizedBox(width: 90, child: Text('$label：$value')),
        Expanded(
          child: Slider(
            value: value.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}

class _DemoCanvas extends StatelessWidget {
  const _DemoCanvas({required this.child});

  /// 演示内容。
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 360),
        child: ColoredBox(
          color: isDark ? const Color(0xff282b30) : const Color(0xfff5f6f8),
          child: Padding(padding: const EdgeInsets.all(24), child: child),
        ),
      ),
    );
  }
}

class _ColorBlock extends StatelessWidget {
  const _ColorBlock({required this.label, required this.color, this.width});

  /// 色块标签。
  final String label;

  /// 色块颜色。
  final Color color;

  /// 可选固定宽度。
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 72,
      child: ColoredBox(
        color: color,
        child: Center(
          child: Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xff1f1f1f))),
        ),
      ),
    );
  }
}

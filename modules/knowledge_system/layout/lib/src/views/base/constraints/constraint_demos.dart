import 'package:flutter/material.dart';

/// 展示 tight、loose 和 expand 三种常见约束。
class ConstraintModesDemo extends StatefulWidget {
  const ConstraintModesDemo({super.key});

  @override
  State<ConstraintModesDemo> createState() => _ConstraintModesDemoState();
}

class _ConstraintModesDemoState extends State<ConstraintModesDemo> {
  /// 当前约束模式。
  _ConstraintMode _mode = _ConstraintMode.tight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _ConstraintCanvas(
            child: Center(
              child: Container(
                constraints: _constraints,
                color: const Color(0xff91caff),
                child: const SizedBox(
                  width: 80,
                  height: 50,
                  child: Center(
                      child: Text('子组件\n80 × 50', textAlign: TextAlign.center)),
                ),
              ),
            ),
          ),
        ),
        SegmentedButton<_ConstraintMode>(
          segments: const <ButtonSegment<_ConstraintMode>>[
            ButtonSegment<_ConstraintMode>(
                value: _ConstraintMode.tight, label: Text('tight')),
            ButtonSegment<_ConstraintMode>(
                value: _ConstraintMode.loose, label: Text('loose')),
            ButtonSegment<_ConstraintMode>(
                value: _ConstraintMode.expand, label: Text('expand')),
          ],
          selected: <_ConstraintMode>{_mode},
          onSelectionChanged: _changeMode,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  BoxConstraints get _constraints => switch (_mode) {
        _ConstraintMode.tight =>
          const BoxConstraints.tightFor(width: 220, height: 120),
        _ConstraintMode.loose =>
          const BoxConstraints(maxWidth: 220, maxHeight: 120),
        _ConstraintMode.expand =>
          const BoxConstraints.expand(width: 220, height: 120),
      };

  void _changeMode(Set<_ConstraintMode> values) {
    setState(() => _mode = values.first);
  }
}

/// ConstrainedBox 为子组件追加最小和最大尺寸。
class ConstrainedBoxDemo extends StatelessWidget {
  const ConstrainedBoxDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return _ConstraintCanvas(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 220,
            minHeight: 120,
            maxWidth: 320,
          ),
          child: const ColoredBox(
            color: Color(0xffb7eb8f),
            child: Center(
                child: Text('内容很短\n但最小尺寸为 220 × 120',
                    textAlign: TextAlign.center)),
          ),
        ),
      ),
    );
  }
}

/// 对比普通父约束和 UnconstrainedBox 解除约束后的结果。
class UnconstrainedComparisonDemo extends StatelessWidget {
  const UnconstrainedComparisonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return _ConstraintCanvas(
      child: Row(
        children: <Widget>[
          Expanded(child: _buildPanel(context, false)),
          const VerticalDivider(width: 32),
          Expanded(child: _buildPanel(context, true)),
        ],
      ),
    );
  }

  Widget _buildPanel(BuildContext context, bool unconstrained) {
    final Widget box = Container(
      width: 200,
      height: 120,
      color: unconstrained ? const Color(0xffb7eb8f) : const Color(0xffffccc7),
      alignment: Alignment.center,
      child: Text(unconstrained ? '200 × 120 生效' : '受父级宽度限制'),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(unconstrained ? 'UnconstrainedBox' : '普通约束',
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 12),
        SizedBox(
          width: 140,
          height: 150,
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: unconstrained
                ? UnconstrainedBox(
                    clipBehavior: Clip.hardEdge,
                    child: box,
                  )
                : box,
          ),
        ),
      ],
    );
  }
}

/// LimitedBox 仅在父级对应轴无界时提供最大尺寸。
class LimitedBoxDemo extends StatelessWidget {
  const LimitedBoxDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return _ConstraintCanvas(
      child: Center(
        child: UnconstrainedBox(
          child: LimitedBox(
            maxWidth: 240,
            maxHeight: 120,
            child: Container(
              width: 500,
              height: 300,
              color: const Color(0xffffd666),
              alignment: Alignment.center,
              child: const Text('父级无界\nLimitedBox 限制为 240 × 120',
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
}

/// OverflowBox 允许子组件尺寸超过父级区域。
class OverflowBoxDemo extends StatelessWidget {
  const OverflowBoxDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ConstraintCanvas(
      child: Center(
        child: SizedBox(
          width: 140,
          height: 90,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xffffccc7)),
            child: OverflowBox(
              minWidth: 220,
              maxWidth: 220,
              minHeight: 140,
              maxHeight: 140,
              child: ColoredBox(
                color: Color(0x9991caff),
                child: Center(
                    child: Text('子组件 220 × 140\n超出父级 140 × 90',
                        textAlign: TextAlign.center)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _ConstraintMode { tight, loose, expand }

class _ConstraintCanvas extends StatelessWidget {
  const _ConstraintCanvas({required this.child});

  /// 演示内容。
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 380),
        child: ColoredBox(
          color: isDark ? const Color(0xff282b30) : const Color(0xfff5f6f8),
          child: Padding(padding: const EdgeInsets.all(24), child: child),
        ),
      ),
    );
  }
}

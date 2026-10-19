import 'package:flutter/material.dart';
import 'package:mermaid_flutter/mermaid_flutter.dart';

import '../reading_code.dart';
import 'reading_mermaid_viewer.dart';

/// Mermaid 围栏直接绘制图表；保留源码以便复制和处理不兼容语法。
class ReadingMermaid extends StatefulWidget {
  /// 未改写的 Mermaid 源码。
  final String source;

  /// 查看源码时沿用普通代码块字号。
  final double fontSize;

  const ReadingMermaid(
      {super.key, required this.source, required this.fontSize});

  @override
  State<ReadingMermaid> createState() => _ReadingMermaidState();
}

class _ReadingMermaidState extends State<ReadingMermaid> {
  /// 图表和源码在同一个阅读位置切换。
  bool _showSource = false;

  /// 保持插件组件和主题身份，普通重建时复用其解析及布局缓存。
  late MermaidDiagram _diagram;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateDiagram();
  }

  @override
  void didUpdateWidget(ReadingMermaid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      _showSource = false;
      _updateDiagram();
    }
  }

  /// 跟随阅读页字体和明暗主题；出错时不残留上一张有效图表。
  void _updateDiagram() {
    _diagram = MermaidDiagram(
        source: widget.source,
        theme: MaterialMermaidTheme.fromTheme(Theme.of(context)),
        keepLastGoodSceneOnError: false,
        errorBuilder: _buildError);
  }

  Widget _buildError(BuildContext context, Object error) => Padding(
      padding: const EdgeInsets.all(16),
      child: Text('图表暂时无法渲染，请切换源码查看。',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant)));

  void _toggleSource() => setState(() => _showSource = !_showSource);

  /// 图表使用独立全屏视口缩放，不拦截正文的滚动手势。
  void _openViewer() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(fullscreenDialog: true, builder: _buildViewer));
  }

  Widget _buildViewer(BuildContext context) =>
      ReadingMermaidViewer(source: widget.source);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: colors.surface,
            border:
                Border.all(color: colors.outlineVariant.withValues(alpha: .5)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 16, right: 4),
              child: Row(children: <Widget>[
                Text('MERMAID',
                    style: TextStyle(
                        fontSize: 11, color: colors.onSurfaceVariant)),
                const Spacer(),
                TextButton(
                    onPressed: _toggleSource,
                    child: Text(_showSource ? '图表' : '源码')),
                IconButton(
                    onPressed: _openViewer,
                    icon: const Icon(Icons.open_in_full, size: 18)),
              ])),
          if (_showSource)
            ReadingCode(
                source: widget.source,
                language: 'mermaid',
                fontSize: widget.fontSize)
          else
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Semantics(
                    label: 'Mermaid 图表，点击放大查看',
                    button: true,
                    child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: _openViewer,
                            child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxHeight: 440),
                                child: SizedBox(
                                    width: double.infinity,
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.topCenter,
                                        child: _diagram))))))),
        ]));
  }
}

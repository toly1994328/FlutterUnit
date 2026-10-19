import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mermaid_flutter/mermaid_flutter.dart';

/// 图表独立放大查看，支持拖动、滚轮或双指缩放及复位。
class ReadingMermaidViewer extends StatefulWidget {
  /// 与正文图表完全一致的源码。
  final String source;

  const ReadingMermaidViewer({super.key, required this.source});

  @override
  State<ReadingMermaidViewer> createState() => _ReadingMermaidViewerState();
}

class _ReadingMermaidViewerState extends State<ReadingMermaidViewer> {
  /// 复位时将整张图重新适配到当前视口。
  final MermaidViewController _controller = MermaidViewController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fit() => _controller.fitAll();

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.source));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('图表源码已复制')));
  }

  Widget _buildError(BuildContext context, Object error) =>
      const Center(child: Text('图表暂时无法渲染，可复制源码检查语法。'));

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('图表'), actions: <Widget>[
        TextButton(onPressed: _fit, child: const Text('适应窗口')),
        TextButton(onPressed: _copy, child: const Text('复制源码')),
        const SizedBox(width: 8),
      ]),
      body: SafeArea(
          child: MermaidView(
              source: widget.source,
              controller: _controller,
              theme: MaterialMermaidTheme.fromTheme(Theme.of(context)),
              keepLastGoodSceneOnError: false,
              errorBuilder: _buildError,
              showControls: false,
              allowFullscreen: false,
              backgroundColor: Theme.of(context).colorScheme.surface)));
}

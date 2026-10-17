import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../loading/skeleton_loading.dart';
import 'reading_image_actions.dart';
import 'reading_image_save.dart';
import 'reading_image_url.dart';

/// 本站文档图片，支持错误提示和点击缩放，保留动图播放。
class ReadingImage extends StatefulWidget {
  /// 已按文档资源目录解析的完整图片地址。
  final String url;

  /// Markdown 图片替代文字。
  final String description;
  const ReadingImage({super.key, required this.url, this.description = ''});

  @override
  State<ReadingImage> createState() => _ReadingImageState();
}

class _ReadingImageState extends State<ReadingImage> {
  /// 保存期间忽略重复长按，避免相册出现重复下载。
  bool _saving = false;

  /// OSS 缩放失败时改用原图，兼容超过变换尺寸限制的长图。
  String? _failedPreview;

  /// 当前图片组件使用的地址，尺寸变化或回退原图后复制也随之更新。
  String? _renderedUrl;

  String get url => widget.url;
  String get description => widget.description;

  /// 复制当前实际渲染的地址，保存和放大继续使用原图。
  Future<void> _actions() async {
    if (_saving) return;
    final ReadingImageAction? action = await showReadingImageActions(context);
    if (!mounted || action == null) return;
    switch (action) {
      case ReadingImageAction.save:
        await _save();
      case ReadingImageAction.copyLink:
        try {
          await Clipboard.setData(ClipboardData(text: _renderedUrl ?? url));
          _message('图片链接已复制');
        } catch (_) {
          _message('复制失败，请重试');
        }
      case ReadingImageAction.zoom:
        _zoom(context);
    }
  }

  /// 显示保存结果，下载失败后恢复菜单操作。
  Future<void> _save() async {
    setState(() => _saving = true);
    _message('正在保存图片…');
    try {
      final String? message = await saveReadingImage(url);
      if (message != null) _message(message);
    } catch (_) {
      _message('图片保存失败，请检查网络或存储空间后重试');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _message(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  /// 导出文件名不作为阅读文案展示，原替代文字仍保留用于无障碍说明。
  String get _title => description.isEmpty ||
          RegExp(r'\.(png|jpe?g|gif|webp|avif|svg)$', caseSensitive: false)
              .hasMatch(description)
      ? '查看图片'
      : description;

  /// 全屏查看图片，鼠标滚轮或手势可缩放。
  void _zoom(BuildContext context) {
    Widget dialog(BuildContext context) => Dialog.fullscreen(
            child: Scaffold(
          appBar: AppBar(title: Text(_title)),
          body: Center(
              child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 5,
                  child: Image(
                      image: CachedNetworkImageProvider(url),
                      fit: BoxFit.contain,
                      errorBuilder: _error))),
        ));
    showDialog<void>(context: context, builder: dialog);
  }

  Widget _error(BuildContext context, Object error, StackTrace? stack) =>
      Container(
        padding: const EdgeInsets.all(24),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const Icon(Icons.broken_image_outlined, size: 32),
          const SizedBox(height: 8),
          Text(description.isEmpty ? '图片暂时无法加载' : '$description（图片暂时无法加载）'),
        ]),
      );
  @override
  Widget build(BuildContext context) => Semantics(
        label: description.isEmpty
            ? '文章图片，点击放大，长按打开菜单'
            : '$description，点击放大，长按打开菜单',
        button: true,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Align(
                alignment: Alignment.center,
                child: Container(
                    constraints: const BoxConstraints(maxHeight: 640),
                    foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outlineVariant
                                .withValues(alpha: .6),
                            width: .75)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LayoutBuilder(builder: _preview))))),
      );

  /// 按阅读区域宽度和屏幕密度请求预览，全屏入口继续使用原始地址。
  Widget _preview(BuildContext context, BoxConstraints constraints) {
    final String requested = readingImageUrl(url,
        width: constraints.maxWidth,
        pixelRatio: MediaQuery.devicePixelRatioOf(context));
    final String preview = _failedPreview == requested ? url : requested;
    _renderedUrl = preview;
    void fallback(Duration time) {
      if (mounted && _failedPreview != requested) {
        setState(() => _failedPreview = requested);
      }
    }

    Widget previewError(BuildContext context, Object error, StackTrace? stack) {
      if (preview == url) return _error(context, error, stack);
      WidgetsBinding.instance.addPostFrameCallback(fallback);
      return _frame(context, const SizedBox(), null, false);
    }

    return InkWell(
        onTap: () => _zoom(context),
        onLongPress: _actions,
        child: Image(
            image: CachedNetworkImageProvider(preview),
            fit: BoxFit.contain,
            errorBuilder: previewError,
            frameBuilder: _frame));
  }

  Widget _frame(
          BuildContext context, Widget child, int? frame, bool synchronous) =>
      synchronous || frame != null
          ? child
          : const SkeletonLoading(
              label: '正在加载文章图片',
              child: SkeletonBlock(
                  height: 160, width: double.infinity, radius: 8));
}

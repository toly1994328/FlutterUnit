import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/exp.dart';
import '../../env/artifact_env.dart';
import 'reading/document_markdown.dart';
import 'reading/reading_image.dart';
import 'reading/reading_code_builder.dart';
import 'reading/reading_inline_code.dart';
import 'reading/reading_content.dart';
import 'reading/reading_header.dart';
import 'reading/reading_theme.dart';
import 'reading/outline_entry.dart';
import 'reading/reading_heading.dart';
import 'reading/reading_navigation.dart';
import 'reading/reading_outline.dart';
import '../loading/content_skeleton.dart';

/// 在线 Markdown 阅读页，正文与相对引用图片都从文档服务读取。
class MarkdownArticlePage extends StatefulWidget {
  /// 当前选中的目录文章。
  final Article article;

  /// 正文仓储，便于验证失败与刷新场景。
  final ArticleRepository repository;
  const MarkdownArticlePage(
      {super.key,
      required this.article,
      this.repository = const ArticleRepository()});
  @override
  State<MarkdownArticlePage> createState() => _MarkdownArticlePageState();
}

class _MarkdownArticlePageState extends State<MarkdownArticlePage> {
  /// 本次正文请求。
  late Future<MarkdownArticle> _document;

  /// 文档目录、惰性章节跳转和阅读进度。
  final ReadingNavigation _navigation = ReadingNavigation();

  /// 窄屏目录抽屉的打开与收起。
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 默认阅读字号，随系统文字缩放适配。
  static const double _fontSize = 14;

  /// 已加载文档的资源解析基准。
  String? _resourceBase;
  @override
  void initState() {
    super.initState();
    _document = widget.repository.openMarkdown(widget.article.id);
  }

  @override
  void dispose() {
    _navigation.dispose();
    super.dispose();
  }

  /// 刷新最新正文并回到开头。
  void _reload() {
    _navigation.reset();
    setState(
        () => _document = widget.repository.openMarkdown(widget.article.id));
  }

  void _top() => _navigation.top();

  Future<void> _selectHeading(OutlineEntry entry) async {
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      _scaffoldKey.currentState?.closeEndDrawer();
    }
    await _navigation.select(entry);
  }

  /// 仅打开 HTTP(S)，本站相对资源以完整文档目录为基准。
  Future<void> _openLink(String text, String? href, String title) async {
    if (href == null) return;
    if (href.startsWith('#')) {
      final bool found = await _navigation.openFragment(href.substring(1));
      if (!found && mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('未找到对应章节')));
      }
      return;
    }
    final Uri? base = Uri.tryParse(_resourceBase ?? widget.article.url);
    final Uri? target = base?.resolve(href) ?? Uri.tryParse(href);
    if (target == null || !<String>['http', 'https'].contains(target.scheme)) {
      return;
    }
    try {
      if (!await launchUrl(target, mode: LaunchMode.externalApplication)) {
        throw StateError('无法打开链接');
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('无法打开链接')));
    }
  }

  @override
  Widget build(BuildContext context) => Theme(
      data: ReadingTheme.theme(Theme.of(context)),
      child: Builder(builder: _scaffold));

  /// 阅读页采用独立文字系统和浅色画布，正文置于居中纸面。
  Widget _scaffold(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        endDrawer: Drawer(
            width: 300,
            child: SafeArea(
                child: ReadingOutline(
                    navigation: _navigation, onSelected: _selectHeading))),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? const Color(0xffF0F2F8)
            : Theme.of(context).colorScheme.surfaceContainerLowest,
        appBar: AppBar(
            automaticallyImplyActions: false,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            forceMaterialTransparency: true,
            flexibleSpace: _topGlass(context),
            title: Text(widget.article.title,
                maxLines: 1, overflow: TextOverflow.ellipsis)),
        body: RawScrollbar(
            thickness: 8,
            radius: const Radius.circular(4),
            thumbColor: const Color(0xff8B8B8B),
            minThumbLength: 48,
            crossAxisMargin: 3,
            mainAxisMargin: 4,
            interactive: false,
            scrollbarOrientation: ScrollbarOrientation.right,
            notificationPredicate: _documentScroll,
            child: FutureBuilder<MarkdownArticle>(
                future: _document, builder: _buildDocument)),
        floatingActionButton: ValueListenableBuilder<double>(
            valueListenable: _navigation.progress, builder: _topButton),
      );

  /// 将经过顶部栏下方的正文模糊处理，返回按钮和标题保持清晰。
  Widget _topGlass(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool dark = colors.brightness == Brightness.dark;
    return SizedBox.expand(
        child: ClipRect(
            child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: (dark ? colors.surface : Colors.white)
                            .withValues(alpha: .68),
                        border: Border(
                            bottom: BorderSide(
                                color:
                                    colors.outlineVariant.withValues(alpha: .4),
                                width: .5)))))));
  }

  /// 最外侧滑块只跟随正文，目录和代码块的滚动不影响其位置。
  bool _documentScroll(ScrollNotification notification) =>
      notification.metrics.axis == Axis.vertical &&
      notification.context?.findAncestorWidgetOfExactType<DocumentMarkdown>() !=
          null;
  Widget _topButton(BuildContext context, double value, Widget? child) =>
      value < 0.1
          ? const SizedBox.shrink()
          : FloatingActionButton.small(
              onPressed: _top,
              tooltip: '回到顶部',
              child: const Icon(Icons.vertical_align_top));

  Widget _image(MarkdownImageConfig image) {
    final Uri? base = Uri.tryParse(_resourceBase ?? widget.article.url);
    final Uri target = base?.resolveUri(image.uri) ?? image.uri;
    if (!<String>['http', 'https'].contains(target.scheme)) {
      return const Text('图片地址不可用');
    }
    return ReadingImage(
        url: ArtifactEnv().resolveResource(target.toString()),
        description: image.alt ?? '');
  }

  Widget _buildDocument(
      BuildContext context, AsyncSnapshot<MarkdownArticle> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return ReadingSkeleton(article: widget.article);
    }
    if (snapshot.hasError || !snapshot.hasData) {
      return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const Text('文章读取失败，可能已隐藏或删除'),
        TextButton(onPressed: _reload, child: const Text('重试')),
      ]));
    }
    _resourceBase = ArtifactEnv().resolveResource(
        snapshot.data!.resourceBaseUrl ?? snapshot.data!.sourceUrl);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints box) =>
            _paper(context, box, snapshot.data!));
  }

  /// 限制正文行宽并为桌面阅读提供留白，窄屏使用完整可用空间。
  Widget _paper(
      BuildContext context, BoxConstraints box, MarkdownArticle document) {
    Widget layout(
            BuildContext context, List<OutlineEntry> entries, Widget? child) =>
        _readingLayout(context, box, document, entries.isNotEmpty);
    return ValueListenableBuilder<List<OutlineEntry>>(
        valueListenable: _navigation.entries, builder: layout);
  }

  Widget _readingLayout(BuildContext context, BoxConstraints box,
      MarkdownArticle document, bool hasOutline) {
    final bool wide = box.maxWidth >= 900 && hasOutline;
    final bool compact = box.maxWidth < 600;
    final double side = compact ? 0 : 24;
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: side),
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: wide ? 1104 : 880),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(child: _paperBody(context, document, compact)),
                      if (wide) ...<Widget>[
                        const SizedBox(width: 24),
                        SizedBox(
                            width: 200,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.paddingOf(context).top + 24),
                                child: ReadingOutline(
                                    navigation: _navigation,
                                    onSelected: _selectHeading))),
                      ],
                    ]))));
  }

  Widget _paperBody(
      BuildContext context, MarkdownArticle document, bool compact) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final BorderRadius radius = BorderRadius.circular(compact ? 0 : 12);
    final MarkdownStyleSheet style = ReadingTheme.markdown(context, _fontSize);
    final ReadingHeadingBuilder headings =
        ReadingHeadingBuilder(style: style, onTapLink: _openLink);
    return Container(
        decoration: BoxDecoration(color: colors.surface, borderRadius: radius),
        clipBehavior: Clip.antiAlias,
        child: DocumentMarkdown(
            navigation: _navigation,
            header:
                ReadingHeader(article: widget.article, title: document.title),
            data: readingBody(document.markdownBody, document.title),
            styleSheet: style,
            builders: <String, MarkdownElementBuilder>{
              'pre': ReadingCodeBuilder(fontSize: _fontSize - 3),
              'code': ReadingInlineCodeBuilder(style: style.code!),
              for (int level = 1; level <= 6; level++) 'h$level': headings,
            },
            sizedImageBuilder: _image,
            onTapLink: _openLink));
  }
}

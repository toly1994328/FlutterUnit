import 'package:flutter/material.dart';
import '../../data/exp.dart';
import '../article/reading/reading_header.dart';
import 'skeleton_loading.dart';

/// 正文尚未取得时先展示已有文章信息，段落用骨架保持阅读结构。
class ReadingSkeleton extends StatelessWidget {
  /// 目录接口已提供的真实标题、作者和标签。
  final Article article;
  const ReadingSkeleton({super.key, required this.article});
  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: _layout);

  /// 与正文共用窄屏边距、桌面外围留白和纸面宽度，避免加载后横向跳动。
  Widget _layout(BuildContext context, BoxConstraints box) =>
      SingleChildScrollView(
          // Scaffold 已将顶部栏占用计入这里的 MediaQuery，不再重复补偿。
          padding: EdgeInsets.fromLTRB(
              box.maxWidth < 600 ? 0 : 24,
              MediaQuery.paddingOf(context).top + 16,
              box.maxWidth < 600 ? 0 : 24,
              0),
          child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 880),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.sizeOf(context).width < 600 ? 20 : 40),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ReadingHeader(
                                article: article, title: article.title),
                            const SizedBox(height: 24),
                            const SkeletonLoading(
                                label: '正在加载文章正文',
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SkeletonBlock(width: 160, height: 20),
                                      SizedBox(height: 24),
                                      _Paragraph(),
                                      SizedBox(height: 24),
                                      _Paragraph(),
                                      SizedBox(height: 24),
                                      AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: SkeletonBlock(
                                              height: double.infinity)),
                                    ])),
                          ])))));
}

class _Paragraph extends StatelessWidget {
  const _Paragraph();
  @override
  Widget build(BuildContext context) => const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SkeletonBlock(),
            SizedBox(height: 12),
            SkeletonBlock(),
            SizedBox(height: 12),
            FractionallySizedBox(widthFactor: .65, child: SkeletonBlock()),
          ]);
}

/// 筛选加载时保留分组与双列选项结构，不绘制可点击的伪标签。
class TopicSkeleton extends StatelessWidget {
  const TopicSkeleton({super.key});
  @override
  Widget build(BuildContext context) => const SkeletonLoading(
      label: '正在加载主题',
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SkeletonBlock(width: 72),
                SizedBox(height: 16),
                _TopicRow(),
                SizedBox(height: 12),
                _TopicRow(),
                SizedBox(height: 12),
                _TopicRow(),
              ])));
}

class _TopicRow extends StatelessWidget {
  const _TopicRow();
  @override
  Widget build(BuildContext context) => const Row(children: <Widget>[
        Expanded(child: SkeletonBlock(height: 40, radius: 8)),
        SizedBox(width: 12),
        Expanded(child: SkeletonBlock(height: 40, radius: 8)),
      ]);
}

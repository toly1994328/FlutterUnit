import 'package:flutter/material.dart';
import 'library_controller.dart';
import 'library_toolbar.dart';
import 'topic_filter_button.dart';

/// 同一套检索控件可用于手机顶部栏或桌面的列表上方。
class LibraryControls extends StatelessWidget {
  /// 与文库列表共用的搜索和筛选状态。
  final LibraryController controller;

  /// 手机使用单行搜索与两个图标按钮。
  final bool compact;
  const LibraryControls(
      {super.key, required this.controller, required this.compact});
  @override
  Widget build(BuildContext context) =>
      ListenableBuilder(listenable: controller, builder: _toolbar);

  Widget _toolbar(BuildContext context, Widget? child) => LibraryToolbar(
      compact: compact,
      search: controller.search,
      onSearch: controller.onSearch,
      onSubmit: controller.onSubmit,
      sort: controller.sort,
      onSort: controller.onSort,
      topicCount: controller.tags.length,
      topicFilter: TopicFilterButton(
          compact: compact,
          selected: controller.tags,
          loadTopics: controller.loadTopics,
          onApply: controller.selectTopics),
      onReset: controller.reset);
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'topic_picker.dart';

/// 手机主题筛选保留草稿，只有确认后才返回已选主题。
Future<List<String>?> showLibraryTopics(
    BuildContext context, List<String> selected, TopicLoader loadTopics) {
  Widget sheet(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double height = math.min(
        640, math.max(420, media.size.height - media.viewInsets.bottom - 80));
    void cancel() => Navigator.of(context).pop();
    void apply(List<String> value) => Navigator.of(context).pop(value);
    return SafeArea(
        top: false,
        child: Padding(
            padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
            child: SingleChildScrollView(
                child: SizedBox(
                    height: height,
                    child: TooltipVisibility(
                        visible: false,
                        child: TopicPicker(
                            loadTopics: loadTopics,
                            selected: selected,
                            onApply: apply,
                            onCancel: cancel))))));
  }

  return showModalBottomSheet<List<String>>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: sheet);
}

/// 手机排序使用底部选项列表，点击后关闭并返回排序值。
Future<String?> showLibrarySort(BuildContext context, String sort) {
  Widget sheet(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    Widget option(String value, String label) => Material(
        type: MaterialType.transparency,
        child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(label, style: const TextStyle(fontSize: 14)),
            selected: sort == value,
            selectedColor: primary,
            trailing: sort == value
                ? Icon(Icons.check, color: primary, size: 20)
                : null,
            onTap: () => Navigator.of(context).pop(value)));
    return SafeArea(
        top: false,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 12),
                      child: Text('文章排序',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))),
                  option('recent', '最新创作'),
                  option('oldest', '最早创作'),
                ])));
  }

  return showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: sheet);
}

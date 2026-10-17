import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/exp.dart';
import 'topic_options.dart';
import '../loading/content_skeleton.dart';

/// 加载当前文库或专栏可见的主题。
typedef TopicLoader = Future<List<ArticleTopic>> Function();

/// 搜索、分组与草稿选择，确认后才更新文章。
class TopicPicker extends StatefulWidget {
  const TopicPicker(
      {super.key,
      required this.loadTopics,
      required this.selected,
      required this.onApply,
      required this.onCancel});

  /// 在线获取主题，失败时允许原地重试。
  final TopicLoader loadTopics;

  /// 打开面板时已生效的选择。
  final List<String> selected;

  /// 提交本次草稿。
  final ValueChanged<List<String>> onApply;

  /// 关闭面板并放弃草稿。
  final VoidCallback onCancel;
  @override
  State<TopicPicker> createState() => _TopicPickerState();
}

class _TopicPickerState extends State<TopicPicker> {
  /// 关闭面板不会污染文章条件的草稿。
  late final Set<String> _selected = widget.selected.toSet();

  /// 本次打开面板使用的请求，输入与勾选不会重复请求。
  late Future<List<ArticleTopic>> _topics;

  /// 分组区域的滚动控制器。
  final ScrollController _scroll = ScrollController();

  /// 搜索框内容。
  final TextEditingController _search = TextEditingController();

  /// 匹配主题名称和分组名称的关键字。
  String _query = '';
  @override
  void initState() {
    super.initState();
    _topics = widget.loadTopics();
  }

  @override
  void dispose() {
    _scroll.dispose();
    _search.dispose();
    super.dispose();
  }

  void _searchChanged(String value) =>
      setState(() => _query = value.trim().toLowerCase());
  void _clearSearch() {
    _search.clear();
    _searchChanged('');
  }

  void _clear() => setState(_selected.clear);
  void _retry() {
    setState(() {
      _topics = widget.loadTopics();
    });
  }

  void _submit() => widget.onApply(_selected.toList());

  /// 达到上限后仍可移除已选主题。
  void _toggle(String id) {
    if (!_selected.contains(id) && _selected.length >= 20) return;
    setState(() =>
        _selected.contains(id) ? _selected.remove(id) : _selected.add(id));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.escape): widget.onCancel,
        },
        child: Focus(
            autofocus: true,
            child: Material(
                type: MaterialType.transparency,
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            const Icon(Icons.tune, size: 18),
                            const SizedBox(width: 8),
                            const Expanded(
                                child: Text('主题筛选',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                            IconButton(
                                tooltip: '关闭主题筛选',
                                onPressed: widget.onCancel,
                                visualDensity: VisualDensity.compact,
                                icon: const Icon(Icons.close, size: 18)),
                          ]),
                          Text('匹配任一所选主题 · 数字为文章数量',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: colors.onSurfaceVariant)),
                          const SizedBox(height: 12),
                          SizedBox(
                              height: 38,
                              child: TextField(
                                  controller: _search,
                                  onChanged: _searchChanged,
                                  style: const TextStyle(fontSize: 13),
                                  decoration: InputDecoration(
                                      hintText: '搜索主题或分组',
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 10),
                                      prefixIcon:
                                          const Icon(Icons.search, size: 18),
                                      suffixIcon: _query.isEmpty
                                          ? null
                                          : IconButton(
                                              tooltip: '清空主题搜索',
                                              onPressed: _clearSearch,
                                              icon: const Icon(Icons.close,
                                                  size: 16)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: BorderSide(
                                              color: colors.outlineVariant))))),
                          const SizedBox(height: 8),
                          Expanded(
                              child: FutureBuilder<List<ArticleTopic>>(
                                  future: _topics, builder: _buildTopics)),
                          Divider(height: 24, color: colors.outlineVariant),
                          Row(children: <Widget>[
                            Expanded(
                                child: Text('最多选择 20 项',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: _selected.length == 20
                                            ? colors.primary
                                            : colors.onSurfaceVariant))),
                            TextButton(
                                onPressed: widget.onCancel,
                                child: const Text('取消')),
                            const SizedBox(width: 8),
                            FilledButton(
                                onPressed: _submit,
                                child: Text(_selected.isEmpty
                                    ? '查看全部文章'
                                    : '应用筛选（${_selected.length}）')),
                          ]),
                        ])))));
  }

  Widget _buildTopics(
      BuildContext context, AsyncSnapshot<List<ArticleTopic>> snapshot) {
    if (snapshot.hasError) {
      return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const Text('主题加载失败'),
        TextButton(onPressed: _retry, child: const Text('重新加载'))
      ]));
    }
    if (!snapshot.hasData) {
      return const TopicSkeleton();
    }
    final List<ArticleTopic> items = snapshot.data!;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                child: Text('已选 ${_selected.length} / 20',
                    style: Theme.of(context).textTheme.bodySmall)),
            TextButton(
                onPressed: _selected.isEmpty ? null : _clear,
                child: const Text('清除选择')),
          ]),
          if (_selected.isNotEmpty)
            Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 72),
                    child: SingleChildScrollView(
                        child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: _selected
                                .map((String id) => _selectedChip(id, items))
                                .toList())))),
          Expanded(
              child: Scrollbar(
                  controller: _scroll,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                      controller: _scroll,
                      child: TopicOptions(
                          topics: items,
                          selected: _selected,
                          query: _query,
                          onToggle: _toggle)))),
        ]);
  }

  Widget _selectedChip(String id, List<ArticleTopic> items) {
    final String name = items
            .where((ArticleTopic item) => item.id == id)
            .map((ArticleTopic item) => item.name)
            .firstOrNull ??
        id;
    return InputChip(
        label: Text(name),
        tooltip: '移除 $name',
        labelStyle: const TextStyle(fontSize: 12),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onDeleted: () => _toggle(id),
        deleteIcon: const Icon(Icons.close, size: 14));
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import '../../bloc/exp.dart';
import '../../data/exp.dart';

/// 顶部工具栏与文章列表共用检索状态，页面位置变化不重建筛选。
class LibraryController extends ChangeNotifier {
  /// 检索与正文始终使用同一文章仓储。
  final ArticleBloc bloc;

  /// 搜索输入保留在控制器中，可放在列表外的顶部栏。
  late final TextEditingController search;

  /// 当前选中的主题标识。
  late List<String> _tags;

  /// 当前创作时间排序。
  late String _sort;

  /// 输入停顿后再向服务端提交。
  Timer? _debounce;

  LibraryController(this.bloc) {
    final ArticleFilter filter = bloc.filter;
    search = TextEditingController(text: filter.query);
    _tags = List<String>.of(filter.tagIds);
    _sort = filter.sort;
  }

  List<String> get tags => List<String>.unmodifiable(_tags);
  String get sort => _sort;

  void onSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), _submit);
  }

  void onSubmit(String value) => _submit();
  void _submit() => unawaited(apply());

  /// 控件和请求条件同时更新，列表监听新查询重置滚动位置。
  Future<void> apply() {
    _debounce?.cancel();
    notifyListeners();
    return bloc.search(query: search.text, tagIds: _tags, sort: _sort);
  }

  void onSort(String? value) {
    if (value == null || value == _sort) return;
    _sort = value;
    _submit();
  }

  void selectTopics(List<String> selected) {
    _tags = List<String>.of(selected);
    _submit();
  }

  void reset() {
    search.clear();
    _tags = <String>[];
    _sort = 'recent';
    _submit();
  }

  Future<List<ArticleTopic>> loadTopics() =>
      bloc.repository.topics(groupId: bloc.groupId);

  @override
  void dispose() {
    _debounce?.cancel();
    search.dispose();
    super.dispose();
  }
}

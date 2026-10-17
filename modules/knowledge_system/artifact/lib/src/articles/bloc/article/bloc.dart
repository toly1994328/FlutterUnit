import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/exp.dart';

/// 管理文章的网络分页与刷新，数据只保存在内存中。
class ArticleBloc extends Cubit<ArticleState> {
  ArticleBloc(this.repository, {this.pageSize = 20, this.groupId})
      : super(const ArticleLoading());

  /// 单次请求数量。
  final int pageSize;

  /// 当前专栏筛选条件。
  final String? groupId;

  /// HTTP 文章仓储。
  final ArticleRepository repository;

  /// 服务端返回的下一页游标。
  String? _nextCursor;

  /// 用于丢弃刷新前尚未完成的响应。
  int _generation = 0;

  /// 当前请求是否仍在执行。
  bool _fetching = false;

  /// 最近一次成功响应的总数。
  int _total = 0;

  /// 是否已成功取得第一页。
  bool _initialized = false;

  /// 当前检索条件，每次变化均重新开始分页。
  ArticleFilter? _filter;

  ArticleFilter get filter =>
      _filter ?? ArticleFilter(groupId: groupId, pageSize: pageSize);
  int get total => _total;

  /// 切换筛选时丢弃旧游标，旧响应通过查询代次隔离。
  Future<void> search(
      {String query = '',
      List<String> tagIds = const <String>[],
      String sort = 'recent'}) {
    _filter = ArticleFilter(
        groupId: groupId,
        pageSize: pageSize,
        query: query.trim(),
        tagIds: List<String>.unmodifiable(tagIds),
        sort: sort);
    return refresh();
  }

  bool get hasMore => _initialized && _nextCursor != null;
  bool get isFetching => _fetching;

  Future<void> init() => refresh();

  /// 开始新一轮查询，旧请求结束时不会覆盖新数据。
  Future<void> refresh() async {
    final int generation = ++_generation;
    _initialized = false;
    _nextCursor = null;
    _total = 0;
    _fetching = true;
    emit(const ArticleLoading());
    await _fetch(generation, append: false);
  }

  /// 只使用服务端游标继续查询，防止重复翻页和末页循环。
  Future<void> loadNextPageMore() async {
    if (_fetching || !hasMore) return;
    _fetching = true;
    emit(ArticleLoading(data: state.data));
    await _fetch(_generation, append: true);
  }

  /// 失败时保留已取得的列表与游标，以便重试同一页。
  Future<void> retry() => _initialized ? loadNextPageMore() : refresh();

  Future<void> _fetch(int generation, {required bool append}) async {
    try {
      final ArticlePage page = await repository.query(
        filter,
        cursor: append ? _nextCursor : null,
      );
      if (isClosed || generation != _generation) return;
      final List<Article> data =
          append ? <Article>[...state.data] : <Article>[];
      final Set<String> ids = data.map((Article article) => article.id).toSet();
      for (final Article article in page.items) {
        if (ids.add(article.id)) data.add(article);
      }
      _nextCursor = page.nextCursor;
      _total = page.total;
      _initialized = true;
      emit(ArticleWithData(data: data, total: _total, hasMore: hasMore));
    } catch (error) {
      if (isClosed || generation != _generation) return;
      emit(ArticleFailed(error.toString(), data: state.data));
    } finally {
      if (generation == _generation) _fetching = false;
    }
  }
}

sealed class ArticleState {
  /// 已取得的文章；加载更多失败时仍保留这些内容。
  final List<Article> data;
  const ArticleState({this.data = const <Article>[]});
}

class ArticleLoading extends ArticleState {
  const ArticleLoading({super.data});
}

class ArticleWithData extends ArticleState {
  /// 筛选后的文章总数。
  final int total;

  /// 是否还有下一页。
  final bool hasMore;
  const ArticleWithData({super.data, this.total = 0, this.hasMore = false});
}

class ArticleFailed extends ArticleState {
  /// 最近一次请求失败的原因。
  final String error;
  const ArticleFailed(this.error, {super.data});
}

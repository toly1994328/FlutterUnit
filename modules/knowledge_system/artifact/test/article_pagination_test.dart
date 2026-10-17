import 'dart:async';

import 'package:artifact/src/articles/bloc/article/bloc.dart';
import 'package:artifact/src/articles/data/exp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('游标分页保留总数，去重且末页停止请求', testPagination);
  test('正在翻页时阻止重复请求', testConcurrentPagination);
  test('刷新后旧响应不能覆盖新列表', testRefreshRace);
  test('分页失败保留内容，重试使用相同游标', testRetry);
  test('空列表与专栏筛选保留服务端结果', testEmptyCollection);
  test('关闭后忽略未完成请求', testClose);
  test('筛选切换隔离旧响应，下一页始终保留筛选条件', testFilterRace);
}

Article article(String id) =>
    Article(id: id, title: id, url: 'https://juejin.cn/post/$id');

class PendingRepository extends ArticleRepository {
  /// 按请求顺序保存可由测试控制完成的响应。
  final List<Completer<ArticlePage>> requests = <Completer<ArticlePage>>[];

  /// 记录请求的服务端游标。
  final List<String?> cursors = <String?>[];

  /// 记录专栏筛选，确保每一页均携带相同条件。
  final List<String?> groups = <String?>[];

  /// 记录每次请求的完整筛选条件。
  final List<ArticleFilter> filters = <ArticleFilter>[];

  @override
  Future<ArticlePage> query(ArticleFilter filter, {String? cursor}) {
    final Completer<ArticlePage> response = Completer<ArticlePage>();
    requests.add(response);
    cursors.add(cursor);
    groups.add(filter.groupId);
    filters.add(filter);
    return response.future;
  }
}

Future<void> testFilterRace() async {
  final PendingRepository repo = PendingRepository();
  final ArticleBloc bloc = ArticleBloc(repo, groupId: '20', pageSize: 2);
  final Future<void> old = bloc.init();
  final List<String> tags = <String>['9', '10'];
  final Future<void> filtered =
      bloc.search(query: '  绘制  ', tagIds: tags, sort: 'oldest');
  tags.clear();
  repo.requests[1].complete(
      ArticlePage(items: <Article>[article('3')], total: 2, nextCursor: '3'));
  await filtered;
  repo.requests[0].complete(
      ArticlePage(items: <Article>[article('8')], total: 50, nextCursor: '8'));
  await old;
  expect(bloc.state.data.single.id, '3');
  final Future<void> next = bloc.loadNextPageMore();
  repo.requests[2]
      .complete(ArticlePage(items: <Article>[article('2')], total: 2));
  await next;
  expect(repo.cursors, <String?>[null, null, '3']);
  for (final ArticleFilter filter in repo.filters.skip(1)) {
    expect(filter.groupId, '20');
    expect(filter.query, '绘制');
    expect(filter.sort, 'oldest');
    expect(filter.tagIds, <String>['9', '10']);
  }
  await bloc.close();
}

Future<void> testPagination() async {
  final PendingRepository repo = PendingRepository();
  final ArticleBloc bloc = ArticleBloc(repo, pageSize: 2);
  final Future<void> first = bloc.init();
  repo.requests[0].complete(ArticlePage(
    items: <Article>[article('5'), article('4')],
    total: 3,
    nextCursor: '4',
  ));
  await first;
  expect((bloc.state as ArticleWithData).total, 3);
  final Future<void> next = bloc.loadNextPageMore();
  repo.requests[1].complete(ArticlePage(
    items: <Article>[article('4'), article('3')],
    total: 3,
  ));
  await next;
  expect(
      bloc.state.data.map((Article item) => item.id), <String>['5', '4', '3']);
  expect(bloc.hasMore, isFalse);
  await bloc.loadNextPageMore();
  expect(repo.cursors, <String?>[null, '4']);
  await bloc.close();
}

Future<void> testConcurrentPagination() async {
  final PendingRepository repo = PendingRepository();
  final ArticleBloc bloc = ArticleBloc(repo);
  final Future<void> first = bloc.init();
  repo.requests[0].complete(ArticlePage(
    items: <Article>[article('2')],
    total: 2,
    nextCursor: '2',
  ));
  await first;
  final Future<void> next = bloc.loadNextPageMore();
  await bloc.loadNextPageMore();
  expect(repo.requests.length, 2);
  repo.requests[1]
      .complete(ArticlePage(items: <Article>[article('1')], total: 2));
  await next;
  await bloc.close();
}

Future<void> testRefreshRace() async {
  final PendingRepository repo = PendingRepository();
  final ArticleBloc bloc = ArticleBloc(repo);
  final Future<void> old = bloc.init();
  final Future<void> fresh = bloc.refresh();
  repo.requests[1]
      .complete(ArticlePage(items: <Article>[article('9')], total: 1));
  await fresh;
  repo.requests[0].complete(ArticlePage(
    items: <Article>[article('2')],
    total: 2,
    nextCursor: '2',
  ));
  await old;
  expect(bloc.state.data.single.id, '9');
  expect(bloc.hasMore, isFalse);
  expect(bloc.isFetching, isFalse);
  await bloc.close();
}

Future<void> testRetry() async {
  final PendingRepository repo = PendingRepository();
  final ArticleBloc bloc = ArticleBloc(repo);
  final Future<void> first = bloc.init();
  repo.requests[0].complete(ArticlePage(
    items: <Article>[article('2')],
    total: 2,
    nextCursor: '2',
  ));
  await first;
  final Future<void> failed = bloc.loadNextPageMore();
  repo.requests[1].completeError(StateError('断网'));
  await failed;
  expect(bloc.state, isA<ArticleFailed>());
  expect(bloc.state.data.single.id, '2');
  final Future<void> retry = bloc.retry();
  repo.requests[2]
      .complete(ArticlePage(items: <Article>[article('1')], total: 2));
  await retry;
  expect(repo.cursors, <String?>[null, '2', '2']);
  expect(bloc.state.data.length, 2);
  await bloc.close();
}

Future<void> testEmptyCollection() async {
  final PendingRepository repo = PendingRepository();
  final ArticleBloc bloc = ArticleBloc(repo, groupId: '9007199254740993');
  final Future<void> first = bloc.init();
  repo.requests[0].complete(const ArticlePage(items: <Article>[], total: 0));
  await first;
  expect(bloc.state, isA<ArticleWithData>());
  expect(bloc.state.data, isEmpty);
  expect(bloc.hasMore, isFalse);
  expect(repo.groups.single, '9007199254740993');
  await bloc.close();
}

Future<void> testClose() async {
  final PendingRepository repo = PendingRepository();
  final ArticleBloc bloc = ArticleBloc(repo);
  final Future<void> first = bloc.init();
  await bloc.close();
  repo.requests[0].complete(const ArticlePage(items: <Article>[], total: 0));
  await first;
  expect(bloc.isClosed, isTrue);
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/note.dart';
import 'package:fx_dio/fx_dio.dart';

/// 首页文章始终由服务端获取，仅在当前进程内保留列表。
class NewsBloc extends Cubit<NewsState> {
  NewsBloc() : super(NewsState(headerNews: const <ArticlePo>[]));

  /// 线上文章仓储。
  final ArticleRepository _repository = HttpArticleRepository();

  /// 防止同时触发重复加载。
  bool _fetching = false;

  void load() => refreshFromNet();

  /// 刷新文章推荐，不使用 SharedPreferences 文章缓存。
  Future<void> refreshFromNet() async {
    if (_fetching) return;
    _fetching = true;
    try {
      final ApiRet<List<ArticlePo>> result = await _repository.getArticlesByTag(
        1,
        filter: const SizeFilter(page: 1, pageSize: 8),
      );
      if (!isClosed && result.success) {
        emit(NewsState(headerNews: result.data));
      }
    } finally {
      _fetching = false;
    }
  }
}

class NewsState {
  /// 当前进程已取得的推荐文章。
  final List<ArticlePo> headerNews;

  NewsState({required this.headerNews});
}

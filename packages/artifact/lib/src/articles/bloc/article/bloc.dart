import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/article.dart';
import '../../data/repository/article_repository.dart';

class ArticleBloc extends Cubit<ArticleState> {
  ArticleBloc(
    this.repository, {
    this.pageSize = 20,
    this.groupId,
  }) : super(ArticleState.empty());

  final int pageSize;
  final int? groupId;
  final ArticleRepository repository;

  /// 初始化时，加载 [pageSize] 条记录
  ///
  void init() {
    _loadDataFromDb(1, pageSize, filter: groupId?.toString(), requestNet: true);
  }

  Future<void> loadNextPageMore() async {
    int curPage = state.data.length ~/ pageSize;
    int nextPage = curPage + 1;
    ArticleFilter filter = ArticleFilter(
      page: nextPage,
      pageSize: pageSize,
      groupId: groupId,
    );
    List<Article> result = await repository.queryByDb(filter);
    int count = await repository.total(filter);
    emit(ArticleWithData(
      data: state.data + result,
      total: count,
    ));
  }

  Future<void> _loadDataFromDb(
    int page,
    int pageSize, {
    bool requestNet = false,
    String? filter,
  }) async {
    ArticleFilter filter = ArticleFilter(
      page: page,
      pageSize: pageSize,
      groupId: groupId,
    );
    List<Article> data = await repository.queryByDb(filter);

    // 没有内存缓存 并且数据库有数据
    if (data.isNotEmpty) {
      emit(ArticleWithData(data: data, total: data.length));
    }
  }

}

sealed class ArticleState {
  final List<Article> data;

  const ArticleState({this.data = const []});

  factory ArticleState.empty() => const ArticleWithData();
}

class ArticleLoading extends ArticleState {
  const ArticleLoading({super.data});
}

class ArticleWithData extends ArticleState {
  final int total;
  const ArticleWithData({super.data, this.total = 0});
}

class ArticleFailed extends ArticleState {
  final String error;
  const ArticleFailed(this.error, {super.data});
}

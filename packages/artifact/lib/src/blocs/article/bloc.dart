import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/utils.dart';

import '../../repositories/model/article.dart';
import '../../repositories/repository/article_repository.dart';

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
    _loadDataFromDbOrNet(1, pageSize, filter: groupId?.toString(),requestNet: true);
  }

  Future<void> loadNextPageMore() async {
    int curPage = state.data.length ~/ pageSize;
    int nextPage = curPage + 1;
    TaskResult<List<Article>> result = await repository.queryByHttp(
      page: nextPage,
      pageSize: pageSize,
      groupId: groupId,
    );
    if (result.success) {
      emit(ArticleWithData(
          data: state.data + result.data!, total: result.count));
      repository.cacheResult(result.data!);
    } else {
      emit(ArticleFailed(result.msg, data: state.data));
    }
  }

  Future<void> _loadDataFromDbOrNet(
    int page,
    int pageSize, {
    bool requestNet = false,
    String? filter,
  }) async {
    /// 没有内存缓存时，查看数据库数据
    List<Article> data = await repository.queryByDbCache(
        page: page, pageSize: pageSize, filter: filter);

    // 没有内存缓存 并且数据库有数据
    if (data.isNotEmpty) {
      emit(ArticleWithData(data: data, total: data.length));
      if (!requestNet) return;
    }
    await _requestNetAndSaveOrUpdate(
        page: page, pageSize: pageSize, groupId: int.tryParse(filter ?? '-'));
  }

  Future<void> _requestNetAndSaveOrUpdate({
    int page = 1,
    int pageSize = 20,
    int? groupId,
  }) async {
    // 此时表示没有缓存数据，并且需要请求网络
    // print("=====ColumnizeBloc::请求网络加载数据==========");
    TaskResult<List<Article>> result = await repository.queryByHttp(
        groupId: groupId, pageSize: pageSize, page: page);
    if (result.success) {
      emit(ArticleWithData(data: result.data!, total: result.count));
      repository.cacheResult(result.data!);
    } else {
      emit(ArticleFailed(result.msg, data: state.data));
    }
  }

  @override
  Future<void> close() async{
    super.close();
    print("=======close:${groupId}==================");
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

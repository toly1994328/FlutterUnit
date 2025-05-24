import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_dao/src/table/dao.dart';
import 'package:note/note.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:app/app.dart';

class NewsBloc extends Cubit<NewsState>
    with Cacheable<List<ArticlePo>>, TimeoutCache<List<ArticlePo>> {
  NewsBloc() : super(NewsState(headerNews: []));

  final ArticleRepository _repository = HttpArticleRepository();

  void initByCache() async {
    List<ArticlePo>? retCache = await find(shouldRemove: false);
    if (retCache != null) {
      emit(NewsState(headerNews: retCache));
      return;
    }
  }

  @override
  String get cacheKey => 'flutter.unit.news';

  void load() async {
    List<ArticlePo>? retCache = await find();
    if (retCache != null) {
      print("=====load in cache=========");
      emit(NewsState(headerNews: retCache));
      return;
    }
    refreshFromNet();
  }

  Future<void> refreshFromNet() async {
    SizeFilter filter = const SizeFilter(
      page: 1,
      pageSize: 8,
    );
    ApiRet<List<ArticlePo>> ret =
        await _repository.getArticlesByTag(1, filter: filter);
    print("=====load in net=========");
    if (ret.success) {
      save(ret.data);
      emit(NewsState(headerNews: ret.data));
    }
  }

  @override
  ConvertorList<List<ArticlePo>> get convertor => (e) {
        return e.map<ArticlePo>(ArticlePo.fromCache).toList();
      };
}

class NewsState {
  final List<ArticlePo> headerNews;

  NewsState({
    required this.headerNews,
  });
}

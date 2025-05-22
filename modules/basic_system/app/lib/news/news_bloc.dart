// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fx_dao/src/model/po.dart';
// import 'package:fx_dao/src/table/dao.dart';
// import 'package:note/note.dart';
// import 'package:fx_dio/fx_dio.dart';
// import 'cacheable.dart';
//
// class NewsBloc extends Cubit<NewsState>
//     with Cacheable<List<ArticlePo>>, TimeoutCache<List<ArticlePo>> {
//   NewsBloc() : super(NewsState(headerNews: []));
//
//   ArticleRepository _repository = HttpArticleRepository();
//
//   @override
//   String get cacheKey => 'flutter.unit.news';
//
//   void load() async {
//     List<ArticlePo>? retCache = await find();
//     if (retCache != null) {
//       print("=====load in cache=========");
//       emit(NewsState(headerNews: retCache));
//       return;
//     }
//     refreshFromNet();
//   }
//
//   Future<void> refreshFromNet() async {
//     ApiRet<List<ArticlePo>> ret = await _repository.getArticlesByTag(1);
//     print("=====load in net=========");
//     if (ret.success) {
//       save(ret.data);
//       emit(NewsState(headerNews: ret.data));
//     }
//   }
//
//   @override
//   ConvertorList<List<ArticlePo>> get convertor => (e) {
//         return e.map(ArticlePo.fromCache).toList();
//       };
// }
//
// class NewsState {
//   final List<ArticlePo> headerNews;
//
//   NewsState({
//     required this.headerNews,
//   });
// }

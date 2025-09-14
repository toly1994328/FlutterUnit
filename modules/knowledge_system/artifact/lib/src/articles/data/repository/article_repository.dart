
import 'package:storage/storage.dart';

import '../dao/article_dao.dart';
import '../exp.dart';



// 仓储: 提供数据
class ArticleRepository {
  const ArticleRepository();

  ArticleDao get dao => AppStorage().article<ArticleDao>();

  // 从数据库加载资源
  Future<List<Article>> queryByDb(ArticleFilter filter) async {
    List<Article> caches = await dao.query(filter);
    return caches;
  }

  Future<int> total(ArticleFilter filter) => dao.total(filter);
}

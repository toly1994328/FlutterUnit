
import 'package:artifact/artifact.dart';
import 'package:storage/storage.dart';

import '../exp.dart';




// 仓储: 提供数据
class ArticleRepository {
  const ArticleRepository();

  ArticleDao get dao => FlutterDbStorage.instance.articleDao;

  // 从数据库加载资源
  Future<List<Article>> queryByDb(ArticleFilter filter) async {
    List<Article> caches = await dao.query(filter);
    return caches;
  }

  Future<int> total(ArticleFilter filter) => dao.total(filter);
}

import 'package:fx_dio/fx_dio.dart';

import '../../env/artifact_env.dart';
import '../model/article.dart';
import '../model/markdown_article.dart';

/// 通过应用注入的 HTTP 环境读取文章目录。
class ArticleRepository {
  const ArticleRepository();

  /// 直接读取本站正文，隐藏或删除文章由服务端拒绝访问。
  Future<MarkdownArticle> openMarkdown(String id) async {
    final ApiRet<MarkdownArticle> result =
        await ArtifactEnv().host.get<MarkdownArticle>(
              '/article/markdown/$id',
              convertor: MarkdownArticle.fromApi,
            );
    if (!result.success) throw StateError(result.msg);
    return result.data;
  }

  /// 游标与专栏条件一并传给服务端，不读取本地数据库。
  Future<ArticlePage> query(ArticleFilter filter, {String? cursor}) async {
    final ApiRet<ArticlePage> result =
        await ArtifactEnv().host.get<ArticlePage>(
              '/article/catalog',
              queryParameters: <String, dynamic>{
                'page_size': filter.pageSize,
                'sort': filter.sort,
                if (filter.query.isNotEmpty) 'query': filter.query,
                if (filter.tagIds.isNotEmpty)
                  'tag_ids': filter.tagIds.join(','),
                if (filter.tagIds.isNotEmpty) 'tag_match': 'any',
                if (filter.groupId != null) 'collection_id': filter.groupId,
                if (cursor != null) 'after_id': cursor,
              },
              convertor: ArticlePage.fromApi,
            );
    if (!result.success) throw StateError(result.msg);
    return result.data;
  }

  /// 获取当前可见文章的主题计数，首页资讯标签由服务端排除。
  Future<List<ArticleTopic>> topics({String? groupId}) async {
    final ApiRet<List<ArticleTopic>> result =
        await ArtifactEnv().host.get<List<ArticleTopic>>('/article/topics',
            queryParameters: <String, dynamic>{
              if (groupId != null) 'collection_id': groupId,
            },
            convertor: _topicsFromApi);
    if (!result.success) throw StateError(result.msg);
    return result.data;
  }

  static List<ArticleTopic> _topicsFromApi(dynamic data) =>
      (data as List<dynamic>).map(ArticleTopic.fromApi).toList();
}

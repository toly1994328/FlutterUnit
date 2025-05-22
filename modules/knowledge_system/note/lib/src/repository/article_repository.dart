import 'dart:convert';

import 'package:fx_dio/fx_dio.dart';

import '../env/env.dart';
import 'model/model.dart';

typedef PaginateList<T> = ({List<T> list, int total});

abstract class ArticleRepository {
  Future<ApiRet<bool>> create(ArticleCreatePayload payload);

  Future<ApiRet<String>> open(int id);

  Future<ApiRet<bool>> write(int id, String content);

  Future<ApiRet<List<ArticlePo>>> list(SizeFilter filter);

  /// 根据标签查询文章列表
  /// [tagId] 标签 id
  /// [filter] 分页信息
  Future<ApiRet<List<ArticlePo>>> getArticlesByTag(
    int tagId, {
    SizeFilter? filter,
  });

  Future<ApiRet<bool>> delete(int id);

  Future<ApiRet<ArticlePo>> update(int id, ArticleUpdatePayload payload);

  Future<ApiRet<Hierarchy>> loadArticleTree();
}

class HttpArticleRepository implements ArticleRepository {
  Host get host => NoteEnv().host;

  @override
  Future<ApiRet<bool>> create(ArticleCreatePayload payload) {
    return host.post(
      '/article',
      data: payload.apiData,
      convertor: (rep) => rep['status'] == true,
    );
  }

  @override
  Future<ApiRet<bool>> delete(int id) {
    return host.delete(
      '/article/$id',
      convertor: (rep) => rep['status'] == true,
    );
  }

  @override
  Future<ApiRet<List<ArticlePo>>> list(SizeFilter filter) {
    return host.get<List<ArticlePo>>(
      '/article',
      queryParameters: {
        'page': filter.page,
        'page_size': filter.pageSize,
      },
      convertor: (data) {
        return data.map<ArticlePo>(ArticlePo.fromApi).toList();
      },
    );
  }

  @override
  Future<ApiRet<String>> open(int id) {
    return host.get(
      '/article/open/$id',
      convertor: (rep) => rep,
    );
  }

  @override
  Future<ApiRet<bool>> write(int id, String content) {
    return host.post(
      '/article/write',
      data: {
        'article_id': id,
        'content': content,
      },
      convertor: (rep) {
        return rep;
      },
    );
  }

  @override
  Future<ApiRet<ArticlePo>> update(int id, ArticleUpdatePayload payload) {
    return host.put<ArticlePo>(
      '/article/$id',
      data: payload.apiData,
      convertor: (rep) {
        return ArticlePo.fromApi(rep);
      },
    );
  }

  @override
  Future<ApiRet<Hierarchy>> loadArticleTree() {
    return host.get<Hierarchy>(
      '/category',
      convertor: (rep) {
        return Hierarchy.fromJson(rep['data']);
      },
    );
  }

  @override
  Future<ApiRet<List<ArticlePo>>> getArticlesByTag(int tagId,
      {SizeFilter? filter}) {
    SizeFilter size = filter ?? const SizeFilter();
    return host.get<List<ArticlePo>>(
      '/article/tag',
      queryParameters: {
        'tag_id': tagId,
        'page': size.page,
        'page_size': size.pageSize,
      },
      convertor: (data) => data.map<ArticlePo>(ArticlePo.fromApi).toList(),
    );
  }
}

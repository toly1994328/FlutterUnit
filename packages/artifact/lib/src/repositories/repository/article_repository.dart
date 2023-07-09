import 'package:dio/dio.dart';
import 'package:storage/storage.dart';
import 'package:utils/utils.dart';

import '../exp.dart';

// 仓储: 提供数据
class ArticleRepository {
  final String host;
  late Dio _dio;

  ArticleRepository(this.host){
    _dio = Dio(BaseOptions(baseUrl: 'http://$host:8080'));
  }

  CacheDao get cacheDao => AppDbStorage.instance.cacheDao;

  Future<TaskResult<List<Article>>> query({
    int page = 1,
    int pageSize = 20,
  }){
     return queryByHttp(page:page,pageSize:pageSize);
  }


  // 缓存数据
  Future<void> cacheResult(List<Article> data) async{
    for(int i=0;i<data.length;i++){
      cacheDao.insertOrUpdate(data[i].toCache);
    }
  }

  // 从数据库加载资源
  Future<List<Article>> queryByDbCache({
    int page = 1,
    int pageSize = 20,
    String? filter,
  }) async {
    List<CachePo> caches = await cacheDao.query(
      type: 1,

      page: page,
      pageSize: pageSize,
    );
    return caches.map(Article.fromCache).toList();
  }


  Future<TaskResult<List<Article>>> queryByHttp({
    int page = 1,
    int pageSize = 20,
    int? groupId,
  }) async {
    Map<String,dynamic> params = {
      'page': page,
      'pageSize': pageSize,
    };

    if(groupId!=null){
      params['groupId'] = groupId;
    }

    var rep = await _dio.get('/api/v1/article', queryParameters: params);
    if(rep.statusCode == 200){
      if(rep.data['status']){
        // 数据访问成功
        List<dynamic> data = rep.data['data'];
        List<Article> result = data.map(Article.fromMap).toList();
        return TaskResult.success(data: result,count: rep.data['total']);
      }
    }

    return TaskResult.error(msg: '请求失败！');
  }
}

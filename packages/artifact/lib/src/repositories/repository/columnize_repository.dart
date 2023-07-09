import 'package:dio/dio.dart';
import 'package:storage/storage.dart';
import 'package:utils/utils.dart';

import '../model/columnize.dart';

// 仓储: 提供数据
class ColumnizeRepository {

  final String host;
  late Dio _dio;

  ColumnizeRepository(this.host){
    _dio = Dio(BaseOptions(baseUrl: 'http://$host:8080'));
  }

  CacheDao get cacheDao => AppDbStorage.instance.cacheDao;

  // 缓存数据
  Future<void> cacheResult(List<Columnize> data) async{
    for(int i=0;i<data.length;i++){
      cacheDao.insertOrUpdate(data[i].toCache);
    }
  }

  // 从数据库加载资源
  Future<List<Columnize>> queryByDbCache({
    int page = 1,
    int pageSize = 20,
  }) async {
    List<CachePo> caches = await AppDbStorage.instance.cacheDao.query(
      type: 0,
      page: page,
      pageSize: pageSize,
    );
    return caches.map(Columnize.fromCache).toList();
  }

  Future<TaskResult<List<Columnize>>> queryByHttp({
    int page = 1,
    int pageSize = 20,
  }) async {
    var rep = await _dio.get('/api/v1/columnize', queryParameters: {
      'page': page,
      'pageSize': pageSize,
    });
    if (rep.statusCode == 200) {
      if (rep.data['status']) {
        // 数据访问成功
        List<dynamic> data = rep.data['data'];
        List<Columnize> result = data.map(Columnize.fromMap).toList();
        return TaskResult.success(data: result, count: rep.data['total']);
      }
    }

    return TaskResult.error(msg: '');
  }

}

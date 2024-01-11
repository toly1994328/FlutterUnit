
import 'package:artifact/artifact.dart';
import 'package:storage/storage.dart';

import '../model/columnize.dart';

// 仓储: 提供数据
class ColumnizeRepository {

  const ColumnizeRepository();

  ColumnizeDao get dao => FlutterDbStorage.instance.columnizeDao;


  // 从数据库加载资源
  Future<List<Columnize>> queryByDb({
    int page = 1,
    int pageSize = 20,
  }) async {
    List<Columnize> caches = await dao.query(
      page: page,
      pageSize: pageSize,
    );
    return caches;
  }


}

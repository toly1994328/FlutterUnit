import 'package:fx_dio/fx_dio.dart';

import '../../env/artifact_env.dart';
import '../model/columnize.dart';

/// 从服务端读取专栏及其文章数量。
class ColumnizeRepository {
  const ColumnizeRepository();

  Future<List<Columnize>> query() async {
    final ApiRet<List<Columnize>> result =
        await ArtifactEnv().host.get<List<Columnize>>(
              '/article/collections',
              convertor: _convertCollections,
            );
    if (!result.success) throw StateError(result.msg);
    return result.data;
  }

  List<Columnize> _convertCollections(dynamic data) =>
      (data as List<dynamic>).map(Columnize.fromApi).toList();
}

import 'package:fx_dao/fx_dao.dart';
import 'dao/cache_dao.dart';



class FlutterUnitDbStore extends FxDb {

  @override
  Iterable<DbTable> get tables => [
    CacheDao()
  ];

  @override
  String get dbname => 'flutter_unit.db';

  @override
  int get version => 1;

  @override
  void afterOpen(String dbpath) {
    super.afterOpen(dbpath);
    print("====Opend:$dbpath===========");
  }

  @override
  Iterable<(int, MigrationOperation)> get migrations => [];

}

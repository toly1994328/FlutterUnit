import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:fx_dao/fx_dao.dart';

import 'package:widget_module/widget_module.dart';
import 'package:widget_repository/widget_repository.dart';

class FlutterDbStore extends FxDb {
  @override
  String get dbname => 'flutter.db';

  @override
  int get version => 1;

  @override
  Future<void> onCreate(Database db, int version) async {}

  @override
  void afterOpen(String dbpath) {
    super.afterOpen(dbpath);
    print("===DbPath:$dbpath==============");
  }

  @override
  Iterable<(int, MigrationOperation)> get migrations => [];

  @override
  Iterable<DbTable> get tables => [
        CategoryDao(),
        WidgetDao(),
        WidgetStatisticsDao(),
        NodeDao(),
        LikeDao(),
      ];
}

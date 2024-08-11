import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:fx_dao/fx_dao.dart';

import 'dao/article_dao.dart';
import 'dao/category_dao.dart';
import 'dao/columnize_dao.dart';
import 'dao/like_dao.dart';
import 'dao/node_dao.dart';
import 'dao/widget_dao.dart';

class FlutterDbStore extends FxDb {
  late WidgetDao _widgetStore;

  WidgetDao get widgetStore => _widgetStore;

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
        WidgetDao(),
        LikeDao(),
        CategoryDao(),
        NodeDao(),
        ArticleDao(),
        ColumnizeDao(),
      ];
}

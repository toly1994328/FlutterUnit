import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:fx_dao/fx_dao.dart';

import 'package:widget_module/widget_module.dart';
import 'package:artifact/artifact.dart';

class ArticleDbStore extends FxDb {
  @override
  String get dbname => 'article.db';

  @override
  int get version => 1;

  @override
  Future<void> onCreate(Database db, int version) async {}

  @override
  Iterable<(int, MigrationOperation)> get migrations => [];

  @override
  Iterable<DbTable> get tables => [
        ColumnizeDao(),
        ArticleDao(),
      ];

  Future<void> clearOldData() async {
    await database.execute('DROP TABLE IF EXISTS columnize');
    await database.execute('DROP TABLE IF EXISTS article');
  }
}

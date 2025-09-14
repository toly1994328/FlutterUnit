import 'package:storage/storage.dart';

import 'db_storage/flutter/article_db_store.dart';
import 'db_storage/flutter/flutter_db_store.dart';
import 'db_storage/flutter_unit/flutter_unit_db_store.dart';

class AppStorage {
  AppStorage._();

  static AppStorage? _instance;

  factory AppStorage() => _instance ??= AppStorage._();

  final FlutterDbStore _flutterDb = FlutterDbStore();
  final FlutterUnitDbStore _flutterUnitDb = FlutterUnitDbStore();

  final ArticleDbStore _articleDb = ArticleDbStore();

  FlutterDbStore get flutter => _flutterDb;
  ArticleDbStore get article => _articleDb;
  FlutterUnitDbStore get flutterUnit => _flutterUnitDb;

  Future<void> init() async {
    await _flutterDb.open();
    await _flutterUnitDb.open();
    await _articleDb.open();
  }

  void close() async {
    await _flutterDb.close();
    await _flutterUnitDb.close();
    await _articleDb.close();
  }
}

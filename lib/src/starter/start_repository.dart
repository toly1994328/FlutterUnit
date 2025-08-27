import 'dart:convert';
import 'dart:io';
import 'package:note/note.dart';
import 'package:app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';
import 'package:path/path.dart' as path;
import 'package:utils/utils.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'bridge/unit_bridge.dart';
import 'package:widget_module/widget_module.dart';
import 'package:storage/storage.dart';

ValueNotifier<double> dbInstallProgress = ValueNotifier(0);

class FlutterUnitStartRepo implements AppStartRepository<AppConfig> {
  const FlutterUnitStartRepo();

  /// 初始化 app 的异步任务
  /// 返回本地持久化的 AppConfig 对象
  @override
  Future<AppConfig> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 滚动性能优化 1.22.0
    GestureBinding.instance.resamplingEnabled = true;
    WindowSizeAdapter.setSize();
    await SpStorage().initSp();
    await initAppMeta();

    registerHttpClient();
    NoteEnv().attachBridge(UnitNoteBridge());
    if (!kAppEnv.isWeb) await initDb();
    await initWidgetStatistics(); // 加载统计数据

    HttpUtil.instance.rebase(PathUnit.baseUrl);
    AppConfigPo po = await SpStorage().appConfig.read();
    AppConfig state = AppConfig.fromPo(po);
    return state;
  }

  Future<void> initDb() async {
    //数据库不存在，执行拷贝
    await AppStorage().init();

    String dbPath = await AppStorage().flutter.dbpath;
    bool shouldCopy = await _checkShouldCopy(dbPath, SpStorage().spf);
    if (shouldCopy) {
      await _doCopyAssetsDb(dbPath);
    } else {
      print("=====flutter.db 已存在====");
    }
  }

  Future<void> _doCopyAssetsDb(String dbPath) async {
    print("=====flutter.db==== assets ======开始拷贝====");
    importArticleSqlFromAssets(AppStorage().article);
    await importSqlFromAssets(AppStorage().flutter, onProgress: (progress) {
      dbInstallProgress.value = progress;
    });
    print("=====flutter.db==== assets ======拷贝完成====");
  }

  Future<bool> _checkShouldCopy(String dbPath, SharedPreferences prefs) async {
    bool shouldCopy = false;
    String versionStr = await rootBundle.loadString('assets/version.json');
    int dbVersion = await json.decode(versionStr)['dbVersion'];
    int versionInSP = prefs.getInt(SpKey.dbVersionKey) ?? -1;

    // 版本升级，执行拷贝
    if (dbVersion > versionInSP) {
      shouldCopy = true;
      await prefs.setInt(SpKey.dbVersionKey, dbVersion);
    }

    //非 release模式，执行拷贝
    if (kDebugMode) {
      shouldCopy = true;
    }

    //数据库不存在，执行拷贝
    if (!File(dbPath).existsSync()) {
      shouldCopy = true;
    }

    return shouldCopy;
  }

  /// 读取 assets/flutter.sql 文件并插入数据到数据库
  /// [flutter] 数据库存储对象
  /// [onProgress] 进度回调，参数为当前进度 (0.0-1.0)
  Future<void> importSqlFromAssets(FlutterDbStore flutter,
      {Function(double)? onProgress}) async {
    try {
      await flutter.clearOldData();
      String sqlContent = await rootBundle.loadString('assets/flutter.sql');

      List<String> sqlStatements = _parseSqlStatements(sqlContent);
      if (sqlStatements.isEmpty) return;

      Database db = flutter.database;
      const int batchSize = 120;

      for (int i = 0; i < sqlStatements.length; i += batchSize) {
        Batch batch = db.batch();
        int end = (i + batchSize < sqlStatements.length)
            ? i + batchSize
            : sqlStatements.length;

        for (int j = i; j < end; j++) {
          String statement = sqlStatements[j];
          if (statement.toUpperCase().startsWith('INSERT')) {
            batch.rawInsert(statement);
          } else {
            batch.execute(statement);
          }
        }

        await batch.commit(noResult: true);
        onProgress?.call(end / sqlStatements.length);
      }
    } catch (e) {
      print('导入 SQL 文件失败: $e');
      rethrow;
    }
  }

  /// 读取 assets/flutter.sql 文件并插入数据到数据库
  /// [flutter] 数据库存储对象
  /// [onProgress] 进度回调，参数为当前进度 (0.0-1.0)
  Future<void> importArticleSqlFromAssets(ArticleDbStore flutter,
      {Function(double)? onProgress}) async {
    try {
      await flutter.clearOldData();
      String sqlContent = await rootBundle.loadString('assets/article.sql');

      List<String> sqlStatements = _parseSqlStatements(sqlContent);
      if (sqlStatements.isEmpty) return;

      Database db = flutter.database;
      const int batchSize = 120;

      for (int i = 0; i < sqlStatements.length; i += batchSize) {
        Batch batch = db.batch();
        int end = (i + batchSize < sqlStatements.length)
            ? i + batchSize
            : sqlStatements.length;

        for (int j = i; j < end; j++) {
          String statement = sqlStatements[j];
          if (statement.toUpperCase().startsWith('INSERT')) {
            batch.rawInsert(statement);
          } else {
            batch.execute(statement);
          }
        }

        await batch.commit(noResult: true);
        onProgress?.call(end / sqlStatements.length);
      }
    } catch (e) {
      print('导入 SQL 文件失败: $e');
      rethrow;
    }
  }

  List<String> _parseSqlStatements(String sqlContent) {
    List<String> statements = [];
    List<String> lines = sqlContent.split('\n');
    StringBuffer buffer = StringBuffer();

    for (String line in lines) {
      line = line.trim();
      if (line.isEmpty) continue;

      buffer.writeln(line);
      String current = buffer.toString().trim().toUpperCase();

      bool isComplete = false;
      if (current.startsWith('CREATE') || current.startsWith('INSERT')) {
        isComplete = line.endsWith(');');
      } else {
        isComplete = line.endsWith(';');
      }

      if (isComplete) {
        statements.add(buffer.toString().trim());
        buffer.clear();
      }
    }

    return statements;
  }
}

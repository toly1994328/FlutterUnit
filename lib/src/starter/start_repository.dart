import 'dart:convert';
import 'dart:io';
import 'package:artifact/artifact.dart';
import 'package:note/note.dart';
import 'package:app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:flutter/services.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';
import 'package:path/path.dart' as path;
import 'bridge/unit_bridge.dart';
import 'package:widget_module/widget_module.dart';

class FlutterUnitStartRepo implements AppStartRepository<AppConfig> {
  const FlutterUnitStartRepo();

  /// 初始化 app 的异步任务
  /// 返回本地持久化的 AppConfig 对象
  @override
  Future<AppConfig> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 沿用当前桌面窗口尺寸；Windows 150% 缩放下正文视口约为 1102 × 823。
    await WindowSizeAdapter.setSize(size: const Size(1113, 829.5));
    await SpStorage().initSp();
    // 清除旧版本持久化的首页文章，后续只从服务端读取。
    await SpStorage().spf.remove('flutter.unit.news');
    await initAppMeta();
    AppConfigPo po = await SpStorage().appConfig.read();

    AppConfig state = AppConfig.fromPo(po);
    // Windows 首次升级自动选择在线文楷，后续尊重用户的字体切换。
    if (!kIsWeb &&
        Platform.isWindows &&
        SpStorage().spf.getBool('windows-wenkai-font-v1') != true) {
      state = state.copyWith(fontFamily: wenKaiLitePackage.family);
      await SpStorage().appConfig.write(state.toAppConfigPo());
      await SpStorage().spf.setBool('windows-wenkai-font-v1', true);
    }
    configureFlutterUnitHttp(state.language.isZh);
    NoteEnv().attachBridge(UnitNoteBridge());
    ArtifactEnv().attachBridge(UnitArtifactBridge());
    if (!kAppEnv.isWeb) await initDb();
    await initWidgetStatistics(); // 加载统计数据

    return state;
  }

  Future<void> initDb() async {
    //数据库不存在，执行拷贝
    String dbPath = await AppStorage().flutter.dbpath;
    await _removeLegacyArticleDb(path.dirname(dbPath));
    bool shouldCopy = await _checkShouldCopy(dbPath, SpStorage().spf);
    if (shouldCopy) {
      await _doCopyAssetsDb(dbPath);
    } else {
      print("=====flutter.db 已存在====");
    }

    String pkgPath = path.join(path.dirname(dbPath), 'packages.db');
    PkgDatabaseHelper().setDbPath(pkgPath);
    await AppStorage().init();
  }

  Future<void> _doCopyAssetsDb(String dbPath) async {
    Directory dir = Directory(path.dirname(dbPath));
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    {
      ByteData data = await rootBundle.load("assets/flutter.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }
    print("=====flutter.db==== assets ======拷贝完成====");
  }

  /// 旧文章目录已迁到服务端，升级时移除遗留的数据库文件。
  Future<void> _removeLegacyArticleDb(String directory) async {
    for (final String suffix in <String>['', '-wal', '-shm', '-journal']) {
      final File legacy = File(path.join(directory, 'article.db$suffix'));
      if (await legacy.exists()) await legacy.delete();
    }
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
}

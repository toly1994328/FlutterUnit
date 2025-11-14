import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PkgDatabaseHelper {
  static final PkgDatabaseHelper _instance = PkgDatabaseHelper._internal();
  static Database? _database;

  PkgDatabaseHelper._internal();

  factory PkgDatabaseHelper() => _instance;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  String? _dbPath;

  void setDbPath(String path) {
    _dbPath = path;
  }

  Future<Database> _initDatabase() async {
    assert(_dbPath != null);
    return await openDatabase(
      _dbPath!,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE t_pkg_categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        name TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE t_pkg_tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE t_pkg_topics (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE t_pkg_packages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL,
        last_version TEXT,
        last_publish TEXT,
        likes INTEGER DEFAULT 0,
        points INTEGER DEFAULT 0,
        downloads INTEGER DEFAULT 0,
        description TEXT,
        publisher TEXT,
        repository TEXT,
        homepage TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE t_pkg_package_categories (
        package_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        PRIMARY KEY (package_id, category_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE t_pkg_package_tags (
        package_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        PRIMARY KEY (package_id, tag_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE t_pkg_package_topics (
        package_id INTEGER NOT NULL,
        topic_id INTEGER NOT NULL,
        PRIMARY KEY (package_id, topic_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE t_pkg_package_dependencies (
        package_id INTEGER NOT NULL,
        dependency_name TEXT NOT NULL,
        version_constraint TEXT,
        PRIMARY KEY (package_id, dependency_name)
      )
    ''');

    await db.execute(
        'CREATE INDEX idx_t_pkg_packages_name ON t_pkg_packages(name)');
    await db.execute('CREATE INDEX idx_t_pkg_tags_name ON t_pkg_tags(name)');
    await db
        .execute('CREATE INDEX idx_t_pkg_topics_name ON t_pkg_topics(name)');
    await db.execute(
        'CREATE INDEX idx_t_pkg_package_categories_package ON t_pkg_package_categories(package_id)');
    await db.execute(
        'CREATE INDEX idx_t_pkg_package_categories_category ON t_pkg_package_categories(category_id)');
  }

  Future<List<String>> getTables() async {
    final db = await database;
    final result =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    return result.map((row) => row['name'] as String).toList();
  }

  Future<List<Map<String, dynamic>>> getTableData(String tableName) async {
    final db = await database;
    return await db.query(tableName);
  }
}

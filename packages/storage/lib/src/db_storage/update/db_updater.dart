
import 'package:sqflite/sqflite.dart';
import 'db_migration.dart';

class DbUpdater {
  static const version = 1;

  Future<void> update(Database db, int oldVersion, int newVersion) async {
    DbMigration dbMigration = DbMigration();
    // dbMigration.addMigration(1, migration_1_2);
    // dbMigration.addMigration(2, migration_2_3);
    // dbMigration.addMigration(3, migration_3_4);
    // dbMigration.addMigration(4, migration_4_5);
    // dbMigration.addMigration(5, migration_5_6);
    await dbMigration.migration(db, oldVersion, newVersion);
  }

  Future<void> migration_1_2(Database database) async {

  }


}

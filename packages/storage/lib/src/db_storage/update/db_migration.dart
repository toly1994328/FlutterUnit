
import 'package:sqflite/sqflite.dart';

typedef MigrationOperation = Future<void> Function(Database database);

class DbMigration{
  final Map<int,MigrationOperation> _migrationMap={};

  void addMigration(int version,MigrationOperation operation){
    _migrationMap[version] = operation;
  }

  Future<void> migration(Database database,int oldVersion,int newVersion) async{
    for(int i=0;i<_migrationMap.length;i++){
      int version = _migrationMap.keys.toList()[i];
      MigrationOperation operation = _migrationMap.values.toList()[i];
      if(version<newVersion&&version>=oldVersion){
        await operation(database);
      }
    }
  }
}
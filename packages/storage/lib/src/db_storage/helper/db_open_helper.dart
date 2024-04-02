import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:ffi';

import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart';


class DbOpenHelper{

  static void setupDatabase(){
    if(Platform.isWindows){
      String location =  Directory.current.path;
      _windowsInit(join(location, 'sqlite3.dll'));
    }
  }

  static void _windowsInit(String path) {
    open.overrideFor(OperatingSystem.windows, () {
      try {
        return DynamicLibrary.open(path);
      } catch (e) {
        stderr.writeln('Failed to load sqlite3.dll at $path');
        rethrow;
      }
    });
    sqlite3.openInMemory().dispose();
  }

  static Future<String> getDbDirPath() async{
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dirName = 'databases';
    String dirPath = path.join(appDocDir.path, dirName);

     if(Platform.isAndroid){
       dirPath = path.join(appDocDir.parent.path, dirName);
     }
    if(Platform.isWindows||Platform.isLinux){
      dirPath = path.join(appDocDir.path, 'FlutterUnit','databases');
    }

    Directory result = Directory(dirPath);
    if(!result.existsSync()){
      result.createSync(recursive: true);
    }
    return dirPath;
  }
}
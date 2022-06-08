// import 'dart:ffi';
// import 'dart:io';
//
// import 'package:sqlite3/open.dart';
// import 'package:sqlite3/sqlite3.dart';
// import 'package:path/path.dart';
//
// setupDatabase(){
//   if(Platform.isWindows){
//     var  location =  Directory.current.path;
//     windowsInit(join(location, 'sqlite3.dll'));
//   }
// }
//
// void windowsInit(String path) {
//   open.overrideFor(OperatingSystem.windows, () {
//     try {
//       return DynamicLibrary.open(path);
//     } catch (e) {
//       stderr.writeln('Failed to load sqlite3.dll at $path');
//       rethrow;
//     }
//   });
//   sqlite3.openInMemory().dispose();
// }
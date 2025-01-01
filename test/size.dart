import 'dart:io';
import 'package:path/path.dart' as p;
void main() async{
  Directory directory=Directory(r'D:\Projects\Flutter\Github\FlutterUnit\build_tools\output');
  List<FileSystemEntity> files = directory.listSync();
  Map<String,dynamic> map = {};
  for(FileSystemEntity file in files){
    if(file is File){
      map[p.basename(file.path)] = file.statSync().size;
    }
  }

  print(map);
}

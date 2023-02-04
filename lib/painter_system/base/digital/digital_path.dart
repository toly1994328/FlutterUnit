
import 'dart:math';

import 'package:flutter/material.dart';

class DigitalPath {

  static const double kDigitalRate = 169/104;

  //
  final Map<String,Path> _digitalPathMap = {};

  DigitalPath(){
    _initDigitalPathMap();
  }

  Path buildPath(int value,double width){
    double rate = width/104;
    Matrix4 matrix4 =  Matrix4.identity();
    matrix4.scale(rate,rate,0.0);
    return _digitalPathMap[value.toString()]!.transform(matrix4.storage);
  }


  Path combineAll(List<Path> paths,
      {PathOperation operation = PathOperation.union}) {
    if (paths.isEmpty) return Path();
    if (paths.length <= 1) return paths.first;
    Path result = paths.first;
    for (int i = 1; i < paths.length; i++) {
      result = Path.combine(operation, paths[i], result);
    }
    return result;
  }

  void _initDigitalPathMap(){
    Map<int,Path> map = {};

    _digitalPathMap.clear();
    double strokeWidth = 26;
    double width = 104;
    double height = 169;
    double gap = 5;
    double angle = 43;

    Path path1 = Path()
      ..moveTo(gap, 0)
      ..relativeLineTo(width-gap*2 , 0)
      ..relativeLineTo(-strokeWidth/tan(angle*pi/180), strokeWidth)
      ..lineTo(strokeWidth/tan(angle*pi/180)+gap, strokeWidth)..close();

    Path path2 = Path()
      ..moveTo(0, 2)
      ..lineTo(0 , 74)
      ..lineTo(13 , 83)
      ..lineTo(26 , 71)
      ..lineTo(26 , 27)
      ..close();

    Matrix4 mirrorY =  Matrix4.identity();
    mirrorY.translate(width/2,0.0);
    mirrorY.scale(-1.0,1.0,0.0);
    mirrorY.translate(-width/2,0.0);
    Path path4 = path2.transform(mirrorY.storage);

    Matrix4 mirrorX = Matrix4.identity();
    mirrorX.translate(0.0,height/2);
    mirrorX.scale(1.0,-1.0,0.0);
    mirrorX.translate(0.0,-height/2);

    Path path5 = path2.transform(mirrorX.storage);
    Path path7 = path5.transform(mirrorY.storage);
    Path path6 = path1.transform(mirrorX.storage);

    Path path3 = Path()
      ..moveTo(18, 84)
      ..lineTo(31 , 97)
      ..lineTo(73 , 97)
      ..lineTo(86 , 85)
      ..lineTo(75 , 74)
      ..lineTo(31 , 74)
      ..close();

    map[1] = path1;
    map[2] = path2;
    map[3] = path3;
    map[4] = path4;
    map[5] = path5;
    map[6] = path6;
    map[7] = path7;

    digitalMap.forEach((key, v) {
      List<Path> paths = v.map<Path>((value) => map[value]!).toList();
      Path path = combineAll(paths);
      _digitalPathMap[key] = path;
    });
  }

  
}

Map<String,List<int>> digitalMap = {
  '0': [1,2,4,5,6,7],
  '1': [4,7],
  '2': [1,4,3,5,6],
  '3': [1,4,3,6,7],
  '4': [2,3,4,7],
  '5': [1,2,3,6,7],
  '6': [1,2,3,5,6,7],
  '7': [1,4,7],
  '8': [1,2,3,4,5,6,7],
  '9': [1,2,3,4,6,7],
};
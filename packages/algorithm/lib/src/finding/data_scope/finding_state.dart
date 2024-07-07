// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-07
// Contact Me:  1981462002@qq.com

import 'dart:math';
import 'package:flutter/material.dart';

import '../../algorithm/finding/functions.dart';
import 'finding_config.dart';
import 'position.dart';
import 'random_queue.dart';

enum FindingStatus{
  none, // 未操作
  finding, // 寻路中
  find, // 寻路完成
}

class FindingState with ChangeNotifier {

  int road = 1; //路
  int wall = 0; //墙

  bool lockMap = false;

  //路径是否被访问过
  List<List<bool>> visitedList = [];

  //迷宫地图
  List<List<int>> blockList = [];

  //寻找到的正确路线
  List<List<bool>> pathList = [];

  //方向
  List<List<int>> direction = [
    [-1, 0],
    [0, -1],
    [1, 0],
    [0, 1]
  ];

  FindingState() {
    reset();
  }

  List<List<int>> cacheBlockList = [[]];

  void lock(){
    print("============lock=====");
    lockMap=true;
    cacheBlockList.clear();
    var (row,col) = _config.size;

    List.generate(row, (i) {
      List<int> tempMazeList = [];
      List.generate(col, (j) {
        tempMazeList.add(blockList[i][j]); //设置为墙
      });
      cacheBlockList.add(tempMazeList);
    });
    notifyListeners();
  }

  void unlock(){
    lockMap=false;
    cacheBlockList.clear();
    notifyListeners();
  }

  void tick(){
    notifyListeners();
  }

  FindingStatus status = FindingStatus.none;
  FindingConfig _config = FindingConfig();
  FindingConfig get config => _config;

  late XY start;
  late XY end;

  void reset(){
    status = FindingStatus.none;
    if(lockMap){
      resetLocMap();
      notifyListeners();
      return;
    }

    var (row,col) = _config.size;
    if (row % 2 == 0 || col % 2 == 0) {
      throw "地图行数和列数不能为偶数";
    }

    start = (1,0);
    end = (row-2,col-1);

    blockList = [];
    visitedList = [];
    pathList = [];
    //初始化迷宫遍历的方向（上、左、右、下）顺序（迷宫趋势）
    //随机遍历顺序，提高迷宫生成的随机性（共12种可能性）
    List.generate(direction.length, (index) {
      int random = Random().nextInt(direction.length);
      List<int> temp = direction[random];
      direction[random] = direction[index];
      direction[index] = temp;
    });

    List.generate(row, (i) {
      List<bool> tempVisited = [];
      List<int> tempMazeList = [];
      List<bool> tempPath = [];
      List.generate(col, (j) {
        //行和列为奇数都设置为路，否则设置为墙
        if (i % 2 == 1 && j % 2 == 1) {
          tempMazeList.add(1); //设置为路
        } else {
          tempMazeList.add(0); //设置为墙
        }
        //初始化访问，所有都没有访问过
        tempVisited.add(false);
        tempPath.add(false);
      });
      visitedList.add(tempVisited);
      blockList.add(tempMazeList);
      pathList.add(tempPath);
    });

    blockList[start.$1][start.$2] = 1;
    blockList[end.$1][end.$2] = 1;
    createMap(start.$1,start.$2+1);
    status = FindingStatus.none;

    notifyListeners();
  }


  ///设置为正确的路径
  void setPath(int x, int y, bool isPath) {
    if (isInMap(x, y)) {
      pathList[x][y] = isPath;
    }
    tick();
  }

  void changeAlgo(String name){
    FindingAlgo algo =  FindingAlgo.values.firstWhere((e)=>e.path==name);
    _config = config.copyWith(algo: algo);
    if(lockMap){

    }
    status = FindingStatus.none;
    notifyListeners();
  }

  void resetLocMap(){
    cacheBlockList = cacheBlockList;
    visitedList = visitedList.map((innerList) => innerList.map((element) => false).toList()).toList();
    pathList = pathList.map((innerList) => innerList.map((element) => false).toList()).toList();
  }

  void run() async{
    status = FindingStatus.finding;
    await config.algo.function(this);
    status = FindingStatus.find;
    notifyListeners();
  }

  /// 创建地图并使用随机队列生成地图结构
  void createMap(int startX, int startY) {
    RandomQueue randomQueue = RandomQueue(); // 创建一个随机队列实例
    Position start = Position(startX, startY); // 创建起始位置
    randomQueue.addRandomQueue(start); // 将起始位置加入随机队列

    visitedList[startX][startY] = true; // 标记起始位置为已访问

    // 使用随机队列生成地图
    while (randomQueue.getSize() != 0) {
      Position position = randomQueue.removeRandomQueue(); // 移除队列中的一个位置

      // 生成四个方向的新位置
      List.generate(4, (i) {
        int newX = position.x! + direction[i][0] * 2;
        int newY = position.y! + direction[i][1] * 2;

        // 检查新位置是否在地图内且未被访问过
        if (isInMap(newX, newY) && !visitedList[newX][newY]) {
          // 将新位置加入随机队列，并记录为已访问
          randomQueue.addRandomQueue(Position(newX, newY, prePosition: position));
          visitedList[newX][newY] = true;

          // 设置新位置与当前位置之间的路径或道路
          setWithRoad(position.x! + direction[i][0], position.y! + direction[i][1]);
        }
      });
    }

    // 把visitedList全部设置为没有访问
    visitedList = visitedList.map((innerList) => innerList.map((element) => false).toList()).toList();
  }

  ///设置为路
  void setWithRoad(int x, int y) {
    blockList[x][y] = road;
  }

  ///用来判断blockList[i][j]是否在地图内
  bool isInMap(int i, int j) {
    return i >= 0 && i < config.size.$1 && j >= 0 && j < config.size.$2;
  }

  Color getBoxColor(int i, int j) {
    Color color = Colors.white;
    if (blockList[i][j] == 0) {
      color = Colors.black54;
    } else if (start.$1 == i && start.$2 == j) {
      color = Colors.blue;
    } else if (end.$1 == i && end.$2 == j) {
      color = Colors.red;
    } else if (visitedList[i][j]) {
      color = Colors.blue.shade200;
    }
    if (pathList[i][j]) {
      color = Colors.orange;
    }
    return color;
  }

}

/// Provides the current [FindingState] to descendant widgets in the tree.
class FindingStateScope extends InheritedNotifier<FindingState> {
  const FindingStateScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static FindingState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FindingStateScope>()!.notifier!;


  static FindingState read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<FindingStateScope>()!.notifier!;
}
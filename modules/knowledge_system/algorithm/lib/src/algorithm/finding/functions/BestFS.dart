// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-07
// Contact Me:  1981462002@qq.com

import 'dart:math';

import '../../../finding/data_scope/finding_state.dart';
import '../functions.dart';
import 'AStar.dart';

/// BestFS算法
Future<bool> findingBestFS(FindingState state)  async {
  XY start = state.start;
  XY end = state.end;

  // 初始化优先队列、起始节点和父节点数组
  PriorityQueue priorityQueue = PriorityQueue();
  var (row,col) = state.config.size;

  Node startNode =
  Node(start, 0, euclideanDistance(start.$1, start.$2, end.$1, end.$2));
  priorityQueue.add(startNode);

  // 初始化 visitedList、pathList 和 parent
  // 初始化路径记录和访问标记
  state.visitedList = List.generate(col, (_) => List.filled(row, false));
  state.pathList = List.generate(col, (_) => List.filled(row, false));
  List<List<int>> parent =
  List.generate(col, (_) => List.filled(row, -1));

  while (!priorityQueue.isEmpty) {
    Node currentNode = priorityQueue.removeFirst();
    int x = currentNode.p.$1;
    int y = currentNode.p.$2;

    // 如果当前节点已访问过，则跳过
    if (state.visitedList[x][y]) continue;
    state.visitedList[x][y] = true;
    state.tick();

    // 检查是否到达终点
    if (x == state.end.$1 && y == state.end.$2) {
      print("找到路径了");

      // 回溯路径
      List<List<int>> path = [];
      int curX = x;
      int curY = y;
      while (curX != -1 && curY != -1) {
        path.add([curX, curY]);
        int prevX = parent[curX][curY] ~/ row;
        int prevY = parent[curX][curY] % row;
        curX = prevX;
        curY = prevY;
        print("curX:$curX,curY:$curY");
        // 防止出现死循环，检查是否回溯到起点
        if (curX == start.$1 && curY == start.$2) {
          break;
        }
      }
      // path = path.reversed.toList();

      // 绘制路径到界面上
      state.pathList =
          List.generate(col, (_) => List.filled(row, false));
      for (var point in path) {
        state.setPath(point[0], point[1], true);
        await Future.delayed(const Duration(milliseconds: 50));
      }
      return true; // 找到路径并绘制完成，返回true
    }

    // 探索当前节点的邻居节点
    for (int i = 0; i < 4; i++) {
      int newX = x + state.direction[i][0];
      int newY = y + state.direction[i][1];

      // 如果邻居节点在地图范围内且是可通行的道路且未访问过
      if (state.isInMap(newX, newY) &&
          state.blockList[newX][newY] == state.road &&
          !state.visitedList[newX][newY]) {
        Node newNode = Node((newX, newY), currentNode.g + 1,
            euclideanDistance(newX, newY, state.end.$1, state.end.$2));
        priorityQueue.add(newNode);
        parent[newX][newY] = x * row + y; // 记录父节点
        state.tick();
        await Future.delayed(const Duration(milliseconds: 50));
      }
    }
  }

  return false; // 未找到路径，返回false
}

double euclideanDistance(int x, int y, int endX, int endY) {
  return sqrt(pow((x - endX).toDouble(), 2) + pow((y - endY).toDouble(), 2));
}
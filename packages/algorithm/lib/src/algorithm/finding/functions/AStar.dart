// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-07
// Contact Me:  1981462002@qq.com

import '../../../finding/data_scope/finding_state.dart';
import '../functions.dart';

/// AStar算法
Future<bool> findingAStar(FindingState state) async {
  XY start = state.start;
  XY end = state.end;
  // 创建优先队列作为开放列表
  PriorityQueue openList = PriorityQueue();
  openList.add(Node(start, 0, heuristic(start, end)));
  var (row, col) = state.config.size;
  // 初始化路径记录和访问标记
  state.visitedList = List.generate(col, (_) => List.filled(row, false));
  state.pathList = List.generate(col, (_) => List.filled(row, false));

  while (!openList.isEmpty) {
    // 从开放列表中移除f值最小的节点作为当前节点
    Node current = openList.removeFirst();
    int x = current.p.$1;
    int y = current.p.$2;

    // 检查当前节点是否超出地图范围
    if (!state.isInMap(x, y)) {
      throw "坐标越界";
    }

    // 如果当前节点已经访问过，则继续下一个节点
    if (state.visitedList[x][y]) continue;
    state.visitedList[x][y] = true;
    state.tick();

    // 检查是否到达终点
    if (x == state.end.$1 && y == state.end.$2) {
      print("找到路径了");
      // 回溯路径
      List<List<int>> path = [];
      Node? curNode = current;
      while (curNode != null) {
        path.add([curNode.p.$1, curNode.p.$2]);
        curNode = curNode.parent;
      }
      // 将路径标记到pathList中，并显示路径动画
      state.pathList = List.generate(col, (_) => List.filled(row, false));
      for (var point in path) {
        state.setPath(point[0], point[1], true);
        await Future.delayed(const Duration(milliseconds: 50));
      }
      return true;
    }

    // 遍历当前节点的四个方向
    for (int i = 0; i < 4; i++) {
      int newX = x + state.direction[i][0];
      int newY = y + state.direction[i][1];

      // 如果新节点在地图范围内且是可通行的空地且未被访问过
      if (state.isInMap(newX, newY) &&
          state.blockList[newX][newY] == state.road &&
          !state.visitedList[newX][newY]) {
        int g = current.g + 1; // 更新新节点的g值
        double h = heuristic((newX, newY), end); // 计算新节点的启发值h
        openList.add(Node((newX, newY), g, h, current)); // 将新节点加入开放列表
        state.tick();
        await Future.delayed(const Duration(milliseconds: 50)); // 延迟显示效果
      }
    }
  }

  return false; // 开放列表为空，未找到路径，搜索失败
}

// 估价函数
double heuristic(XY start, XY end) {
  return ((start.$1 - end.$1).abs() + (start.$2 - end.$2).abs()).toDouble();
}

class Node {
  XY p; // 坐标
  int g; // 节点的坐标和当前路径长度g值
  double h; // 启发值h
  Node? parent; // 父节点

  Node(this.p, this.g, this.h, [this.parent]);

  double get f => g + h; // 计算节点的总代价f值
}

class PriorityQueue {
  final List<Node> _queue = []; // 优先队列使用的列表

  bool get isEmpty => _queue.isEmpty; // 判断队列是否为空

  void add(Node node) {
    _queue.add(node); // 添加节点到队列
    _queue.sort((a, b) => a.f.compareTo(b.f)); // 根据f值排序，f值小的在前面
  }

  Node removeFirst() {
    return _queue.removeAt(0); // 移除并返回队列中f值最小的节点
  }
}

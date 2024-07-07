// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-07
// Contact Me:  1981462002@qq.com


import '../../../finding/data_scope/finding_state.dart';
import '../functions.dart';

  /// 深度优先搜索（DFS）寻找路径
  Future<bool> findingDFS(FindingState state) async {
    XY start = state.start;
    XY end = state.end;
    var (row,col) = state.config.size;

    // 初始化访问标记、路径记录和父节点记录
    state.visitedList = List.generate(col, (_) => List.filled(row, false));
    state.pathList = List.generate(col, (_) => List.filled(row, false));
    List<List<List<int>>> parent = List.generate(col, (_) => List.generate(row, (_) => [-1, -1]));

    // 定义DFS递归函数
    Future<bool> dfs(int x, int y) async {
      // 检查当前位置是否越界
      if (!state.isInMap(x, y)) {
        throw "坐标越界";
      }

      // 如果已经访问过当前位置，则返回 false
      if (state.visitedList[x][y]) return false;
      state.visitedList[x][y] = true; // 标记当前位置为已访问
      state.tick();

      // 检查是否到达终点
      if (x == state.end.$1 && y == state.end.$2) {
        print("找到路径了");

        // 回溯路径并记录到 path 列表中
        List<List<int>> path = [];
        int curX = x;
        int curY = y;
        while (curX != -1 && curY != -1) {
          path.add([curX, curY]);
          List<int> prev = parent[curX][curY];
          curX = prev[0];
          curY = prev[1];
        }

        // 清空原路径记录，并设置新的路径记录为找到的路径
        state.pathList =
            List.generate(col, (_) => List.filled(row, false));
        for (var point in path) {
          state.setPath(point[0], point[1], true); // 设置路径标记
          await Future.delayed(const Duration(milliseconds: 50));
        }
        return true; // 返回找到路径的结果
      }

      // 遍历当前位置的四个方向
      for (int i = 0; i < 4; i++) {
        int newX = x + state.direction[i][0];
        int newY = y + state.direction[i][1];

        // 检查新位置是否在地图范围内，并且是可通过的道路，并且未访问过
        if (state.isInMap(newX, newY) &&
            state.blockList[newX][newY] == state.road &&
            !state.visitedList[newX][newY]) {
          parent[newX][newY] = [x, y]; // 记录新位置的父节点
          state.tick(); // 更新界面状态（如果在 Flutter 中）
          await Future.delayed(const Duration(milliseconds: 50));
          if (await dfs(newX, newY)) {
            return true; // 如果找到路径，则返回 true
          }
        }
      }

      return false; // 如果当前位置无法继续搜索，则返回 false
    }

    // 调用DFS函数并返回最终结果
    return await dfs(start.$1, start.$2);
  }
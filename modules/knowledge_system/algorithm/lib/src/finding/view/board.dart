// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-07
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';

import '../data_scope/finding_state.dart';

class MazeBoard extends StatelessWidget {
  const MazeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    FindingState state = FindingStateScope.of(context);

    return LayoutBuilder(
      builder: (ctx,cts){
        double side = cts.biggest.shortestSide*0.9;
        double cellSize = side / state.config.size.$1;

        List<Row> rowList = [];
        List.generate(state.blockList.length, (i) {
          List<Container> columnList = [];
          List.generate(state.blockList[i].length, (j) {
            columnList.add(Container(
              width: cellSize,
              height: cellSize,
              decoration: BoxDecoration(
                color: state.getBoxColor(i, j),
              ),
            ));
          });

          rowList.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: columnList,
          ));
        });

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowList,
        );
      },
    );
  }
}

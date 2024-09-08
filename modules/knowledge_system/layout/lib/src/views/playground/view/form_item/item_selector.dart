// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-30
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

typedef NameCalc<T> = String Function(T data);

class ItemSelector<T> extends StatelessWidget {
  final int selectIndex;
  final List<T> data;
  final NameCalc<T> calcFun;
  final ValueChanged<T> onSelect;
  final String label;
  final String subTitle;

  const ItemSelector({
    super.key,
    required this.selectIndex,
    required this.data,
    required this.calcFun,
    required this.onSelect,
    required this.subTitle,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(color: Color(0xff61666d), fontSize: 12);
    DropMenuCellStyle lightStyle = const DropMenuCellStyle(
        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
        borderRadius: BorderRadius.all(Radius.circular(6)),
        foregroundColor: Color(0xff1f1f1f),
        backgroundColor: Colors.transparent,
        disableColor: Color(0xffbfbfbf),
        hoverBackgroundColor: Color(0xfff5f5f5),
        hoverForegroundColor: Color(0xff1f1f1f),
        textStyle: TextStyle(fontSize: 11)
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: labelStyle),
              Text(subTitle, style: labelStyle.copyWith(fontSize: 8)),
            ],
          ),
          const Spacer(),
          TolySelect(
            fontSize: 11,
            cellStyle: lightStyle,
            data: data.map((e) => calcFun(e)).toList(),
            selectIndex: selectIndex,
            iconSize: 16,
            height: 25,
            width: 110,
            maxHeight: 200,
            shrinkWrapWidthOverlay: false,
            minWidth: 0,
            onSelected: (int index) => onSelect(data[index]),
          )
        ],
      ),
    );
  }
}

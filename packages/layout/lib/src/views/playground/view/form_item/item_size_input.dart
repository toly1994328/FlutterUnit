// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-29
// Contact Me:  1981462002@qq.com

import 'package:flutter/cupertino.dart';

class ItemSizeInput extends StatelessWidget {
  final TextEditingController widthCtrl;
  final TextEditingController heightCtrl;

  const ItemSizeInput({
    super.key,
    required this.widthCtrl,
    required this.heightCtrl,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(color: Color(0xff61666d), fontSize: 12);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Text('宽高: ', style: labelStyle),
          const SizedBox(width: 20),
          Expanded(
              child: CupertinoTextField(
            controller: widthCtrl,
            style: const TextStyle(fontSize: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              "x",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
              child: CupertinoTextField(
            controller: heightCtrl,
            style: const TextStyle(fontSize: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ))
        ],
      ),
    );
  }
}

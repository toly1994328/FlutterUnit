// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-30
// Contact Me:  1981462002@qq.com

import 'package:flutter/cupertino.dart';

class ValueInput extends StatelessWidget {
  final String label;
  final String subtitle;
  final ValueChanged<String> onChange;

  const ValueInput({
    super.key,
    required this.onChange,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(color: Color(0xff61666d), fontSize: 12);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: labelStyle),
              Text(subtitle, style: labelStyle.copyWith(fontSize: 8)),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 110,
            child: CupertinoTextField(
              keyboardType: TextInputType.number,
              onChanged: onChange,
              style: const TextStyle(fontSize: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          )
        ],
      ),
    );
  }
}

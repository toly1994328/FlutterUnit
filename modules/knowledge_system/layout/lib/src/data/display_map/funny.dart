// Copyright 2014 The 星星 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      星星
// CreateTime:  2024-07-02
// Contact Me:  1981462002@qq.com

import 'package:flutter/cupertino.dart';

import '../../views/interest/elevator/elevator.dart';
import '../model/display_frame.dart';

List<DisplayFrame> get funnyElevator => [
  DisplayFrame(
    title: '电梯布局',
    desc: "模拟完成电梯的运行。",
    src: '',
    display: (BuildContext context) => ElevatorRoom(),
  ),
];

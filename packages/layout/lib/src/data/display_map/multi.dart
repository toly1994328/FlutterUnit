import 'package:flutter/material.dart';
import 'package:layout/src/views/base/positioned/positioned_show.dart';
import 'package:layout/src/views/playground/view/stack/stack_playground.dart';

import '../../views/base/align/align_show.dart';
import '../../views/base/align/align_show2.dart';
import '../../views/base/padding/inner_padding.dart';
import '../../views/base/padding/outer_padding.dart';
import '../../views/base/padding/sizedbox_padding.dart';
import '../../views/base/size/size_loss_by_align.dart';
import '../../views/base/size/size_tight_constraint.dart';
import '../../views/base/size/size_unconstraint.dart';
import '../../views/multi/flex/column_show.dart';
import '../../views/playground/view/flex/flex_playground.dart';
import '../../views/multi/flex/row_show.dart';
import '../../views/playground/view/wrap/wrap_playground.dart';
import '../model/display_frame.dart';

List<DisplayFrame> get multiFlex => [
      DisplayFrame(
        title: 'Flex PlayGround',
        desc: "在 Flex PlayGround 中，你可以通过交互来直观体验 Flex 布局特性。灰色是 Flex 布局区域。",
        src: '',
        display: (BuildContext context) => const FlexPlayground(),
      ),
      DisplayFrame(
        title: 'Row 组件横向排列',
        desc: "可以将若干个组件横向排列，区域宽度无上限约束，子组件总宽超过时会越界异常。详细布局特性见第三页: Flex PlayGround",
        src: '',
        display: (BuildContext context) => const RowShow(),
      ),
      DisplayFrame(
        title: 'Column 组件横向排列',
        desc: "可以将若干个组件竖向排列，区域高度无上限约束，子组件总高超过时会越界异常。详细布局特性见第三页: Flex PlayGround",
        src: '',
        display: (BuildContext context) => const ColumnShow(),
      ),
    ];

List<DisplayFrame> get multiWrap => [
      DisplayFrame(
        title: 'Wrap PlayGround',
        desc: "在 Wrap PlayGround 中，你可以通过交互来直观体验 Wrap 布局特性。",
        src: '',
        display: (BuildContext context) => WrapPlayground(),
      ),
    ];

List<DisplayFrame> get multiStack => [
  DisplayFrame(
    title: 'Stack PlayGround',
    desc: "在 Stack PlayGround 中，你可以通过交互来直观体验 Stack 布局特性。",
    src: '',
    display: (BuildContext context) => StackPlayground(),
  ),
];


import 'package:flutter/material.dart';
import 'package:layout/src/views/base/positioned/positioned_show.dart';

import '../../views/base/align/align_show.dart';
import '../../views/base/align/align_show2.dart';
import '../../views/base/padding/inner_padding.dart';
import '../../views/base/padding/outer_padding.dart';
import '../../views/base/padding/sizedbox_padding.dart';
import '../../views/base/size/size_loss_by_align.dart';
import '../../views/base/size/size_tight_constraint.dart';
import '../../views/base/size/size_unconstraint.dart';
import '../model/display_frame.dart';

List<DisplayFrame> get baseSize => [
      DisplayFrame(
        title: '父级中的紧约束',
        desc: "当前虽然指定 SizeBox 宽高为 150*100。但由于父级的紧约束被强制固定尺寸。"
            "下一步，将父级的紧约束改为宽松约束。",
        src: '',
        display: (BuildContext context) => const SizeTightConstraint(
          info: "受到紧约束\n尺寸无法生效",
        ),
      ),
      DisplayFrame(
        title: '用布局组件放宽父级约束',
        desc:
            "通过嵌套 Align、Row、Column、Flex、Scaffold 等组件， 提供一个宽松的父级约束，让 SizeBox 指定的尺寸可以生效"
            "就可以生效。",
        src: '',
        display: (BuildContext context) => const LossDisplay(),
      ),
      DisplayFrame(
        title: '用 UnconstrainedBox 组件解除约束',
        desc: "通过嵌套 UnconstrainedBox 组件，可以解除之前父级对当前区域的约束，从而使指定尺寸生效。",
        src: '',
        display: (BuildContext context) => const SizeUnconstrain(),
      ),
    ];

List<DisplayFrame> get basePadding => [
  DisplayFrame(
    title: 'Padding 实现内边距',
    desc: "将色块区域视为边界，文字距离边界有一定的内边距。",
    src: '',
    display: (BuildContext context) => const InnerPadding(),
  ),
  DisplayFrame(
    title: 'Padding 实现外边距',
    desc:
    "两个色块区域之间,右侧可以通过 Padding 嵌套，距离外部有边距。Container 的 margin 属性就是这个原理。",
    src: '',
    display: (BuildContext context) => const OuterPadding(),
  ),
  DisplayFrame(
    title: 'SizedBox 实现边距',
    desc:
    "有时在行列布局中，可以通过空白的 SizedBox 组件进行站位，来简单地实现边距效果。",
    src: '',
    display: (BuildContext context) => const SizedBoxPadding(),
  ),
];

List<DisplayFrame> get baseAlign => [
  DisplayFrame(
    title: 'Align 组件实现对齐',
    desc: "Align 组件可以在自身区域内(示例中灰色)，对子组件(蓝色)进行对齐定位。",
    src: '',
    display: (BuildContext context) => const AlignShow(),
  ),
  DisplayFrame(
    title: 'Align 实现 sin 排布',
    desc: "由于Alignment对象可指定在父容器中宽高的分率位置，可以使用Align实现一些复杂的排布需求，比如按指定的数学方程变化位置。",
    src: '',
    display: (BuildContext context) => const AlignShow2(),
  ),
];

List<DisplayFrame> get basePostioned => [
  DisplayFrame(
    title: 'Positioned 组件实现定位',
    desc: "Positioned 组件可以在 Stack 组件内，对子组件指定位置(左上右下)进行定位布局。",
    src: '',
    display: (BuildContext context) => const PositionedShow(),
  ),
];
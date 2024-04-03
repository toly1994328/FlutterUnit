import 'package:flutter/cupertino.dart';

import '../../views/base/size/size_tight_constraint.dart';
import '../../views/base/size/size_loss_by_align.dart';
import '../../views/base/size/size_unconstraint.dart';

class DisplayFrame {
  final String title;
  final String desc;
  final String src;
  final WidgetBuilder display;

  DisplayFrame({
    required this.title,
    required this.desc,
    required this.src,
    required this.display,
  });
}

Map<String, List<DisplayFrame>> get kDisplayMap => {
      '/base/size': [
        DisplayFrame(
          title: '父级中的紧约束',
          desc: "当前虽然指定 SizeBox 宽高为 150*100。但由于父级的紧约束被强制固定尺寸。"
              "下一步，将父级的紧约束改为宽松约束。",
          src: '',
          display: (BuildContext context) => const SizeTightConstraint(info: "受到紧约束\n尺寸无法生效",),
        ),
        DisplayFrame(
          title: '用布局组件放宽父级约束',
          desc: "通过嵌套 Align、Row、Column、Flex、Scaffold 等组件， 提供一个宽松的父级约束，让 SizeBox 指定的尺寸可以生效"
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
      ]
    };

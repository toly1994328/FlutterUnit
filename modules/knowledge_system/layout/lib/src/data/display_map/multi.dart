import 'package:flutter/material.dart';
import 'package:layout/src/views/playground/view/stack/stack_playground.dart';

import '../../views/multi/flex/column_show.dart';
import '../../views/multi/flex_space/flex_space_demos.dart';
import '../../views/playground/view/flex/flex_playground.dart';
import '../../views/multi/flex/row_show.dart';
import '../../views/playground/view/wrap/wrap_playground.dart';
import '../../views/scroll/grid_view/grid_view_demo01.dart';
import '../../views/scroll/list_view/list_view_demo01.dart';
import '../../views/scroll/page_view/page_view_demo01.dart';
import '../model/display_frame.dart';

List<DisplayFrame> get multiFlex => [
      DisplayFrame(
        title: 'Flex PlayGround',
        desc: "在 Flex PlayGround 中，你可以通过交互来直观体验 Flex 布局特性。灰色是 Flex 布局区域。",
        src:
            'modules/knowledge_system/layout/lib/src/views/playground/view/flex/flex_playground.dart',
        display: (BuildContext context) => const FlexPlayground(),
      ),
      DisplayFrame(
        title: 'Row 组件横向排列',
        desc:
            "可以将若干个组件横向排列，区域宽度无上限约束，子组件总宽超过时会越界异常。详细布局特性见第三页: Flex PlayGround",
        src:
            'modules/knowledge_system/layout/lib/src/views/multi/flex/row_show.dart',
        display: (BuildContext context) => const RowShow(),
      ),
      DisplayFrame(
        title: 'Column 组件横向排列',
        desc:
            "可以将若干个组件竖向排列，区域高度无上限约束，子组件总高超过时会越界异常。详细布局特性见第三页: Flex PlayGround",
        src:
            'modules/knowledge_system/layout/lib/src/views/multi/flex/column_show.dart',
        display: (BuildContext context) => const ColumnShow(),
      ),
    ];

List<DisplayFrame> get multiFlexSpace => <DisplayFrame>[
      DisplayFrame(
        title: 'Expanded 填满剩余空间',
        desc: 'Row 先为固定宽度子组件分配空间，再将剩余主轴空间全部交给 Expanded。',
        src:
            'modules/knowledge_system/layout/lib/src/views/multi/flex_space/flex_space_demos.dart',
        display: (BuildContext context) => const ExpandedFillDemo(),
      ),
      DisplayFrame(
        title: 'flex 比例分配',
        desc: '拖动两个 flex 值，观察 Expanded 如何按比例瓜分 Row 的剩余宽度。',
        src:
            'modules/knowledge_system/layout/lib/src/views/multi/flex_space/flex_space_demos.dart',
        display: (BuildContext context) => const FlexRatioDemo(),
      ),
      DisplayFrame(
        title: 'Flexible tight 与 loose',
        desc: 'loose 允许子组件小于可用空间；tight 强制子组件占满 Flex 分配给它的空间。',
        src:
            'modules/knowledge_system/layout/lib/src/views/multi/flex_space/flex_space_demos.dart',
        display: (BuildContext context) => const FlexibleFitDemo(),
      ),
      DisplayFrame(
        title: 'Spacer 弹性间距',
        desc: 'Spacer 本质是不可见的 Expanded，可用 flex 控制多个空白区域的比例。',
        src:
            'modules/knowledge_system/layout/lib/src/views/multi/flex_space/flex_space_demos.dart',
        display: (BuildContext context) => const SpacerDemo(),
      ),
      DisplayFrame(
        title: '固定宽度溢出与弹性修复',
        desc: '业务行布局中优先保证固定操作区，再用 Expanded 或 Flexible 承担会伸缩的主体内容。',
        src:
            'modules/knowledge_system/layout/lib/src/views/multi/flex_space/flex_space_demos.dart',
        display: (BuildContext context) => const FlexOverflowSolutionDemo(),
      ),
    ];

List<DisplayFrame> get multiWrap => [
      DisplayFrame(
        title: 'Wrap PlayGround',
        desc: "在 Wrap PlayGround 中，你可以通过交互来直观体验 Wrap 布局特性。",
        src:
            'modules/knowledge_system/layout/lib/src/views/playground/view/wrap/wrap_playground.dart',
        display: (BuildContext context) => const WrapPlayground(),
      ),
    ];

List<DisplayFrame> get multiStack => [
      DisplayFrame(
        title: 'Stack PlayGround',
        desc: "在 Stack PlayGround 中，你可以通过交互来直观体验 Stack 布局特性。",
        src:
            'modules/knowledge_system/layout/lib/src/views/playground/view/stack/stack_playground.dart',
        display: (BuildContext context) => const StackPlayground(),
      ),
    ];

List<DisplayFrame> get listView => [
      DisplayFrame(
        title: 'ListView 滑动列表',
        desc: "通过 ListView.builder 构造，可以实现按需加载的滑动视图。",
        src:
            'modules/knowledge_system/layout/lib/src/views/scroll/list_view/list_view_demo01.dart',
        display: (BuildContext context) => const ListViewDemo01(),
      ),
    ];

List<DisplayFrame> get gridView => [
      DisplayFrame(
        title: 'GridView 滑动网格',
        desc: "通过 GridView.builder 构造，可以实现按需加载的网格滑动视图。",
        src:
            'modules/knowledge_system/layout/lib/src/views/scroll/grid_view/grid_view_demo01.dart',
        display: (BuildContext context) => GridViewDemo01(),
      ),
    ];

List<DisplayFrame> get pageView => [
      DisplayFrame(
        title: 'PageView 滑动界面',
        desc: "通过 GridView.builder 构造，可以实现按需加载的网格滑动视图。",
        src:
            'modules/knowledge_system/layout/lib/src/views/scroll/page_view/page_view_demo01.dart',
        display: (BuildContext context) => PageViewDemo01(),
      ),
    ];

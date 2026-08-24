import 'package:flutter/material.dart';

import '../../views/overview/layout_overview.dart';
import '../../views/popable/autocomplete_demo.dart';
import '../../views/popable/dropdown_button_demo.dart';
import '../../views/popable/dropdown_menu_demo.dart';
import '../model/display_frame.dart';
import 'base.dart';
import 'multi.dart';

Map<String, List<DisplayFrame>> get kDisplayMap => {
      '/home': <DisplayFrame>[
        DisplayFrame(
          title: '布局宝库总览',
          desc: '从左侧选择一个布局主题，逐页查看原理说明与可交互案例。',
          src:
              'modules/knowledge_system/layout/lib/src/views/overview/layout_overview.dart',
          display: (BuildContext context) => const LayoutOverview(),
        ),
      ],
      '/base/size': baseSize,
      '/base/constraints': baseConstraints,
      '/base/padding': basePadding,
      '/base/align': baseAlign,
      '/base/positioned': basePostioned,
      '/multi/flex': multiFlex,
      '/multi/flex-space': multiFlexSpace,
      '/multi/wrap': multiWrap,
      '/multi/stack': multiStack,
      '/scroll/list': listView,
      '/scroll/grid': gridView,
      '/scroll/page': pageView,
      '/popable/DropdownButton': <DisplayFrame>[
        DisplayFrame(
          title: '下拉按钮 DropdownButton',
          desc: '从预先构建的条目中选择一个值，适合数量较少且不需要文本过滤的选项。',
          src:
              'modules/knowledge_system/layout/lib/src/views/popable/dropdown_button_demo.dart',
          display: (BuildContext context) => const CustomDropDownButton(),
        ),
      ],
      '/popable/DropdownMenu': <DisplayFrame>[
        DisplayFrame(
          title: '下拉菜单 DropdownMenu',
          desc: 'Material 3 下拉菜单支持文本输入、选项过滤和选择结果回调。',
          src:
              'modules/knowledge_system/layout/lib/src/views/popable/dropdown_menu_demo.dart',
          display: (BuildContext context) => const DropdownMenuNode1(),
        ),
      ],
      '/popable/Autocomplete': <DisplayFrame>[
        DisplayFrame(
          title: '自动填充 Autocomplete',
          desc: '根据输入内容异步筛选候选项，适合搜索建议和名称补全。',
          src:
              'modules/knowledge_system/layout/lib/src/views/popable/autocomplete_demo.dart',
          display: (BuildContext context) => const AutocompleteDemo(),
        ),
      ],
    };

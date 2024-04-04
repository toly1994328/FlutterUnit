import 'package:flutter/material.dart';

import '../../views/base/size/size_loss_by_align.dart';
import '../../views/base/size/size_tight_constraint.dart';
import '../../views/base/size/size_unconstraint.dart';
import '../../views/popable/autocomplete_demo.dart';
import '../../views/popable/dropdown_button_demo.dart';
import '../../views/popable/dropdown_menu_demo.dart';
import '../model/display_frame.dart';
import 'base.dart';

Map<String, List<DisplayFrame>> get kDisplayMap => {
  '/base/size': baseSize,
  '/base/padding': basePadding,
  '/base/align': baseAlign,
  '/base/positioned': basePostioned,

  // '/popable/DropdownButton': [
  //   DisplayFrame(
  //     title: '下拉按钮 DropdownButton',
  //     desc:
  //     "Material 风格的下拉选择按钮。基于 Navigator 导航实现，推入 _DropdownRoute 路由，所以点击外部区域时，弹框消失，且外部无法响应该次点击事件。视图构建逻辑非常固定，可定制性低。条目一次性完全加载，不适合海量条目。",
  //     src: '',
  //     display: (BuildContext context) => const CustomDropDownButton(),
  //   ),
  // ],
  // '/popable/DropdownMenu': [
  //   DisplayFrame(
  //     title: '下拉按钮 DropdownMenu',
  //     desc:
  //     "Material 风格的下拉选择按钮。基于 Navigator 导航实现，推入 _DropdownRoute 路由，所以点击外部区域时，弹框消失，且外部无法响应该次点击事件。视图构建逻辑非常固定，可定制性低。条目一次性完全加载，不适合海量条目。",
  //     src: '',
  //     display: (BuildContext context) => const DropdownMenuNode1(),
  //   ),
  // ],
  // '/popable/Autocomplete': [
  //   DisplayFrame(
  //     title: '自动填充 Autocomplete',
  //     desc:
  //     "Material 风格的下拉选择按钮。基于 Navigator 导航实现，推入 _DropdownRoute 路由，所以点击外部区域时，弹框消失，且外部无法响应该次点击事件。视图构建逻辑非常固定，可定制性低。条目一次性完全加载，不适合海量条目。",
  //     src: '',
  //     display: (BuildContext context) => const AutocompleteDemo(),
  //   ),
  // ],
};
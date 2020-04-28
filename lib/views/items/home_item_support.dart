import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/model/widget_model.dart';

import 'coupon_widget_list_item.dart';
import 'techno_widget_list_item.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明:

class HomeItemSupport {
  static Widget get(
    WidgetModel model,
    int index,
  ) {
    switch (index) {
      case 0:
        return TechnoWidgetListItem(data: model);
      case 1:
        return TechnoWidgetListItem(data: model, isClip: false);
      case 2:
        return CouponWidgetListItem(data: model);
      case 3:
        return CouponWidgetListItem(hasTopHole: false, data: model);
      case 4:
        return CouponWidgetListItem(
            hasTopHole: true, hasBottomHole: true, data: model);
      case 5:
        return CouponWidgetListItem(isClip: false, data: model);
    }
    return TechnoWidgetListItem(data: model);
  }

  static List<Widget> itemSimples() => [
        TechnoWidgetListItem(data: getContainer()),
        TechnoWidgetListItem(
          data: getContainer(),
          isClip: false,
        ),
        CouponWidgetListItem(data: getContainer()),
        CouponWidgetListItem(hasTopHole: false, data: getContainer()),
        CouponWidgetListItem(
            hasTopHole: true, hasBottomHole: true, data: getContainer()),
        CouponWidgetListItem(isClip: false, data: getContainer()),
      ];

  static WidgetModel getContainer() => WidgetModel(
      id: Random().nextInt(10000),
      name: 'Container',
      nameCN: "",
      lever: 5,
      family: WidgetFamily.statelessWidget,
      info: '用于容纳单个子组件的容器组件。集成了若干个单子组件的功能，如内外边距、形变、装饰、约束等...');
}

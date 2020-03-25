import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unit/app/Convert.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/database/po/widget_po.dart';

enum WidgetType {
  singe_show, //单一展示型 0
  structure, //结构型 1
  shape, //可形变 2
  event, //事件型 3
  ability, //功能型 4
  layout, //布局型 5
  scroll, //滚动型
}

class WidgetModel extends Equatable {
  final int id;
  final String name;
  final String nameCN;
  final WidgetFamily family;
  final WidgetType type;
  final double lever;
  final ImageProvider image;
  final String info;

  Color get color => Color(Cons.tabColors[family.index]);

  const WidgetModel(
      {this.id,
      this.name,
      this.nameCN,
      this.family,
      this.type,
      this.lever,
      this.image,
      this.info});

  @override
  List<Object> get props => [name, nameCN, family, type, lever, image, info];

  static WidgetModel fromPo(WidgetPo po) {
    return WidgetModel(
      id: po.id,
      name: po.name,
      nameCN: po.nameCN,
      family: Convert.toFamily(po.family),
      image: convertImage(po.image),
      lever: po.lever,
      info: po.info,
    );
  }

  static convertImage(String image) {
    return image.isEmpty ? null : AssetImage(image);
  }
}

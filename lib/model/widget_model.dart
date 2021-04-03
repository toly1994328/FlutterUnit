import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unit/app/utils/convert.dart';
import 'package:flutter_unit/model/enums.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/repositories/bean/widget_po.dart';

/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明: 组件信息-展示-数据模型
///

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
  final bool deprecated;
  final WidgetType type;
  final List<int> links;
  final double lever;
  final ImageProvider image;
  final String info;

  Color get color => Color(Cons.tabColors[family.index]);

  const WidgetModel(
      {this.id,
      this.name,
      this.nameCN,
      this.family,
      this.deprecated,
        this.links,
      this.type,
      this.lever,
      this.image,
      this.info});

  @override
  List<Object> get props => [id];

  static WidgetModel fromPo(WidgetPo po) {
    return WidgetModel(
      id: po.id,
      name: po.name,
      nameCN: po.nameCN,
      family: Convert.toFamily(po.family),
      image: convertImage(po.name),
      lever: po.lever,
      deprecated: po.deprecated == 1,
      info: po.info,
      links: formatLinkTo(po.linkWidget),
    );
  }

  static convertImage(String name) {
    // return image.isEmpty ? null : AssetImage(image);
    return null;
  }


  @override
  String toString() {
    return 'WidgetModel{id: $id, name: $name, nameCN: $nameCN, family: $family, deprecated: $deprecated, type: $type, links: $links, lever: $lever, image: $image, info: $info}';
  }

  static List<int> formatLinkTo(String links) {
    if(links.isEmpty){
      return [];
    }
    if(!links.contains(',')){
      return [int.parse(links)];
    }
    return links.split(',').map<int>((e)=>int.parse(e)).toList();
  }
}

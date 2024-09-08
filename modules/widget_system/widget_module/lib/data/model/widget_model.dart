import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:storage/storage.dart';

import 'enums.dart';


/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明: 组件信息-展示-数据模型
///

const List<Color> kTabColors = [
  Color(0xff44D1FD),
  Color(0xffFD4F43),
  Color(0xffB375FF),
  Color(0xFF4CAF50),
  Color(0xFFFF9800),
  Color(0xFF00F1F1),
  Color(0xFFDBD83F),
];

class WidgetModel extends Equatable {
  final int id;
  final String name;
  final String nameCN;
  final WidgetFamily family;
  final bool deprecated;
  final bool death;
  final List<int> links;
  final double lever;
  final ImageProvider? image;
  final String info;


  const WidgetModel(
      {
        required this.id,
        required  this.name,
        required this.nameCN,
        required  this.family,
         this.deprecated =false,
         this.death =false,
        required this.links,
        // required this.type,
        required this.lever,
      this.image,
        required this.info});

  @override
  List<Object> get props => [id];

  Color get color => kTabColors[family.index];

  static WidgetModel fromPo(WidgetPo po) {
    return WidgetModel(
      id: po.id,
      name: po.name,
      nameCN: po.nameCN,
      family: toFamily(po.family),
      image: convertImage(po.name),
      lever: po.lever,
      deprecated: po.deprecated == 1,
      death: po.deprecated == -1,
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
    return 'WidgetModel{id: $id, name: $name, nameCN: $nameCN, family: $family, deprecated: $deprecated, links: $links, lever: $lever, image: $image, info: $info}';
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

  static WidgetFamily toFamily(int id) {
    switch (id) {
      case 0:
        return WidgetFamily.statelessWidget;
      case 1:
        return WidgetFamily.statefulWidget;
      case 2:
        return WidgetFamily.singleChildRenderObjectWidget;
      case 3:
        return WidgetFamily.multiChildRenderObjectWidget;
      case 4:
        return WidgetFamily.sliver;
      case 5:
        return WidgetFamily.proxyWidget;
      case 6:
        return WidgetFamily.other;
      default:
        return WidgetFamily.statelessWidget;
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unit/app/utils/convert.dart';
import 'package:flutter_unit/widget_system/repositories/model/enums.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/widget_system/repositories/repositories.dart';


/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明: 组件信息-展示-数据模型
///


class WidgetModel extends Equatable {
  final int id;
  final String name;
  final String nameCN;
  final WidgetFamily family;
  final bool deprecated;
  final List<int> links;
  final double lever;
  final ImageProvider? image;
  final String info;

  Color get color => Cons.tabColors[family.index];

  const WidgetModel(
      {
        required this.id,
        required  this.name,
        required this.nameCN,
        required  this.family,
         this.deprecated =false,
        required this.links,
        // required this.type,
        required this.lever,
      this.image,
        required this.info});

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
}

import 'package:flutter/material.dart';

class WidgetItem {
  final String name;
  final String nameCN;
  final ImageProvider image;
  final String info;
  final double lever;

  const WidgetItem({this.name, this.nameCN, this.image, this.info, this.lever});

  factory WidgetItem.fromJson(Map<String, dynamic> map) {
    var image = AssetImage(map["image"]);
    return WidgetItem(
        name: map['name'],
        nameCN: map["nameCN"],
        lever: map["lever"],
        image: image,
        info: map["info"]);
  }

  @override
  String toString() {
    return 'WidgetItem{name: $name, nameCN: $nameCN, image: $image, info: $info, lever: $lever}';
  }


}

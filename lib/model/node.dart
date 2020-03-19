import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Node extends Equatable {
  final String name;
  final String subtitle;
  final String code;
  final Widget widget;

  const Node({this.name, this.subtitle, this.code,this.widget});

  @override
  List<Object> get props => [name, subtitle, code];

  factory Node.fromJson(Map<String, dynamic> map,Widget widget) {
    return Node(
        name: map['name'],
        subtitle: map["subtitle"],
        widget:widget,
        code: map["code"]);

  }
}

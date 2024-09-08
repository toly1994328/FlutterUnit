import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'field.dart';

class Class {
  final List<Field> fields;
  final String name;
  final bool toJson;
  final bool fromJson;
  final bool copyWith;

  Class({
    required this.fields,
    this.toJson = true,
    this.fromJson = true,
    this.copyWith = true,
    required this.name,
  });

  Class copy({
    List<Field>? fields,
    String? name,
    bool? toJson,
    bool? fromJson,
    bool? copyWith,
  }) {
    return Class(
      fields: fields ?? this.fields,
      name: name ?? this.name,
      toJson: toJson ?? this.toJson,
      fromJson: fromJson ?? this.fromJson,
      copyWith: copyWith ?? this.copyWith,
    );
  }

  Future<void> write2File(Directory directory) {
    File file = File(path.join(directory.path, "${fileName}.dart"));
    return file.writeAsString(buildClass());
  }

  RegExp regExp = RegExp(r'[A-Z].*?(?=([A-Z]|\b))');

  String get fileName {
    return regExp
        .allMatches(name)
        .map((e) => e.group(0)?.toLowerCase())
        .join("_");
  }

  String buildClass() {
    String defines = '';
    String constructParams = '';
    String toJsonStatements = '';
    String fromJsonStatements = '';
    String copyWithParamStatements = '';
    String copyWithStatements = '';
    for (int i = 0; i < fields.length; i++) {
      Field field = fields[i];
      defines += "${field.defineStatement}\n";
      constructParams += field.paramStatement;
      toJsonStatements += field.toJsonStatement;
      fromJsonStatements += field.fromJsonStatement;
      copyWithParamStatements += field.copyWithParamStatement;
      copyWithStatements += field.copyWithStatement;
      if (i != fields.length - 1) {
        constructParams += '\n';
        toJsonStatements += '\n';
        fromJsonStatements += '\n';
        copyWithParamStatements += '\n';
        copyWithStatements += '\n';
      }
    }

    String result = """
class $name {
$defines
  $name({
$constructParams
  });

  $name copyWith({
$copyWithParamStatements
  }) =>
      $name(
$copyWithStatements
      );
      
      static $name fromJson(Map<String, dynamic> map) => $name(
$fromJsonStatements
      );

  Map<String,dynamic> toJson()=>{
$toJsonStatements
  };
}
""";
    return result;
  }
}

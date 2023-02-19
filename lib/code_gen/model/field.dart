import 'package:flutter/material.dart';

class Field {
  final String modifier;
  final String  name;
  final bool nullable;
  final bool isRequired;
  final String type ;

  Field({
    this.nullable = false,
    this.isRequired = true,
    this.modifier = '',
   required this.type,
    required this.name,
  });

  String get defineStatement {
    String nullableArg = nullable ? '?' : '';
    return '  $modifier $type$nullableArg $name;';
  }

  String get paramStatement {
    String requiredArg = isRequired ? 'required' : '';
    return '    $requiredArg this.$name,';
  }

  String get toJsonStatement {
    return '        "$name": $name,';
  }

  String get fromJsonStatement {
    return '        $name: map["$name"] ,';
  }

  String get copyWithParamStatement {
    return '    $type? $name,';
  }

  String get copyWithStatement {
    return '        $name: $name ?? this.$name,';
  }
}
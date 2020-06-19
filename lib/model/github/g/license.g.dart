// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../license.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

License _$LicenseFromJson(Map<String, dynamic> json) {
  return License(
    json['name'] as String,
    json['spdx_id'] as String,
  );
}

Map<String, dynamic> _$LicenseToJson(License instance) => <String, dynamic>{
      'name': instance.name,
      'spdx_id': instance.spdxId,
    };

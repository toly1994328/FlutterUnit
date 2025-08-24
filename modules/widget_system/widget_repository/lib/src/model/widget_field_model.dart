import 'package:equatable/equatable.dart';

/// Widget字段模型
class WidgetFieldModel extends Equatable {
  final int id;
  final int widgetId;
  final String fieldName;
  final String fieldType;
  final String? fieldDesc;
  final String? fieldDescZh;
  final int fieldOrder;
  final bool isRequired;

  const WidgetFieldModel({
    required this.id,
    required this.widgetId,
    required this.fieldName,
    required this.fieldType,
    this.fieldDesc,
    this.fieldDescZh,
    required this.fieldOrder,
    required this.isRequired,
  });

  @override
  List<Object?> get props => [
        id,
        widgetId,
        fieldName,
        fieldType,
        fieldDesc,
        fieldDescZh,
        fieldOrder,
        isRequired,
      ];

  factory WidgetFieldModel.fromJson(Map<String, dynamic> json) {
    return WidgetFieldModel(
      id: json['id'],
      widgetId: json['widget_id'],
      fieldName: json['field_name'],
      fieldType: json['field_type'],
      fieldDesc: json['field_desc'],
      fieldDescZh: json['field_desc_zh'],
      fieldOrder: json['field_order'],
      isRequired: json['is_required'] == 1,
    );
  }
}
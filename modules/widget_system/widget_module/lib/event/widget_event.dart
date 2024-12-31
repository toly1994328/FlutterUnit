import 'package:fx_trace/fx_trace.dart';

import '../widget_module.dart';

class SelectWidgetEvent extends FxEvent {
  final String name;
  final int? id;
  final WidgetModel? model;


  SelectWidgetEvent({
    required this.name,
    this.id,
    this.model,
  });
}

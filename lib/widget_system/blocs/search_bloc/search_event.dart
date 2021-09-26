
import 'package:flutter_unit/widget_system/repositories/repositories.dart';


abstract class SearchEvent{//事件基
  const SearchEvent();
}

class SearchWidgetEvent extends SearchEvent {
  final SearchArgs args;//参数
  const SearchWidgetEvent({required this.args});
}

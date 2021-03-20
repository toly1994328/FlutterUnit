
import 'package:flutter_unit/repositories/dao/widget_dao.dart';

abstract class SearchEvent{//事件基
  const SearchEvent();
}

class SearchWidgetEvent extends SearchEvent {
  final SearchArgs args;//参数
  const SearchWidgetEvent({this.args});
}

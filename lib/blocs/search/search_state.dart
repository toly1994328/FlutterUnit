

import 'package:flutter_unit/model/widget_model.dart';

abstract class SearchState {//基态
  const SearchState();
}

class SearchStateNoSearch extends SearchState {}//无搜索状态

class SearchStateEmpty extends SearchState {}//结果为空

class SearchStateLoading extends SearchState {}//加载中
class SearchStateError extends SearchState {}//异常

class SearchStateSuccess extends SearchState {//有结果
  final List<WidgetModel> result;//搜索结果
  const SearchStateSuccess(this.result);
}

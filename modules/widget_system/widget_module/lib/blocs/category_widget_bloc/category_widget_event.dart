part of 'category_widget_bloc.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:

abstract class CategoryWidgetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventLoadCategoryWidget extends CategoryWidgetEvent {
  final int categoryId;
  final String locale;

  EventLoadCategoryWidget(this.categoryId, this.locale);

  @override
  List<Object> get props => [categoryId, locale];
}

class EventToggleCategoryWidget extends CategoryWidgetEvent {
  final int categoryId;
  final int widgetId;

  EventToggleCategoryWidget(this.categoryId, this.widgetId);

  @override
  List<Object> get props => [categoryId, widgetId];
}

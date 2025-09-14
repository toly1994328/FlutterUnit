import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_repository/widget_repository.dart';

part 'widget_detail_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 组件详情页状态数据维护核心类
/// [_modelStack] 组件详情页支持管理跳转，栈数据交由 Bloc 维护

class WidgetDetailBloc extends Cubit<DetailState> {
  final WidgetRepository widgetRepo;
  final NodeRepository nodeRepo;

  WidgetDetailBloc({
    required this.widgetRepo,
    required this.nodeRepo,
  }) : super(DetailLoading());

  List<WidgetModel> _modelStack = [];

  WidgetModel get currentWidget => _modelStack.last;

  void push(WidgetModel model, {String? locale}) {
    _modelStack.add(model);
    queryDetail(model, locale: locale);
  }

  Future<bool> pop() async {
    if (_modelStack.isEmpty) {
      return true;
    }
    _modelStack.removeLast();
    if (_modelStack.isNotEmpty) {
      queryDetail(currentWidget);
      return false;
    } else {
      return true;
    }
  }

  void queryDetail(WidgetModel widget, {String? locale}) async {
    emit(DetailLoading());
    try {
      final List<NodeModel> nodes =
          await nodeRepo.loadNode(widget.id, locale: locale);
      final List<WidgetModel> links =
          await widgetRepo.loadWidget(widget.links, locale);
      emit(DetailWithData(widgetModel: widget, nodes: nodes, links: links));
    } catch (e, s) {
      print("queryDetail=error===${e}=$s==");
      emit(DetailFailed());
    }
  }

  void changeLocale(Locale locale) async {
    String localeStr =
        '${locale.languageCode}-${locale.countryCode}'.toLowerCase();
    List<int> ids = _modelStack.map((e) => e.id).toList();
    _modelStack = await widgetRepo.loadWidget(ids, localeStr);
    queryDetail(currentWidget, locale: localeStr);
  }
}

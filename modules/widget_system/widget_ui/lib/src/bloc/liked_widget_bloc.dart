import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_repository/widget_repository.dart';

/// create by 张风捷特烈 on 2020-04-07
/// contact me by email 1981462002@qq.com
/// 说明:

class LikeWidgetBloc extends Cubit<List<WidgetModel>> {
  final WidgetRepository repository;

  LikeWidgetBloc({required this.repository}) : super(const []);

  Future<void> loadLikeData() async {
    List<WidgetModel> widgets = await repository.loadLikeWidgets();
    emit(widgets);
  }

  Future<void> toggle(int widgetId) async {
    await repository.toggleLike(widgetId);
    return loadLikeData();
  }
}

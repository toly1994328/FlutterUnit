import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/action/widget_action.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'package:widget_repository/widget_repository.dart';
import 'package:widget_ui/widget_ui.dart';
import '../../mobile/widget_detail/collect_widget_list_item.dart';
import '../../mobile/widget_detail/widget_detail_page.dart';

class DeskLikePage extends StatelessWidget {
  const DeskLikePage({Key? key}) : super(key: key);

  final SliverGridDelegate deskGridDelegate =
      const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 300,
    mainAxisSpacing: 15,
    mainAxisExtent: 80,
    crossAxisSpacing: 15,
  );

  @override
  Widget build(BuildContext context) {
    LikeWidgetBloc bloc = context.watch<LikeWidgetBloc>();
    List<WidgetModel> state = bloc.state;
    return GridView.builder(
        itemCount: state.length,
        padding: EdgeInsets.all(20),
        gridDelegate: deskGridDelegate,
        itemBuilder: (_, index) => GestureDetector(
            onTap: () => _toDetailPage(context, state[index]),
            child: CollectWidgetListItem(
              data: state[index],
              onDeleteItemClick: (model) => context.toggleLike(model.id),
            )));
  }

  ShapeBorder get rRectBorder => const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)));

  _toDetailPage(BuildContext context, WidgetModel model) {
    // BlocProvider.of<WidgetDetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.push(
        context, SlidePageRoute(child: WidgetDetailPageScope(model: model)));
  }
}

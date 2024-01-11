import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';

import '../../../data/exp.dart';
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

    LikeWidgetBloc bloc =  context.watch<LikeWidgetBloc>();
    LikeWidgetState state = bloc.state;
    return GridView.builder(
        itemCount: state.widgets.length,
        padding: EdgeInsets.all(20),
        gridDelegate: deskGridDelegate, itemBuilder:  (_, index) => GestureDetector(
        onTap: () => _toDetailPage(context, state.widgets[index]),
        child: CollectWidgetListItem(
          data: state.widgets[index],
          onDeleteItemClick: (model) =>
              _deleteCollect(context, model),
        )));

    return SizedBox.shrink();

  }


  ShapeBorder get rRectBorder => const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)));


  _deleteCollect(BuildContext context, WidgetModel model) =>
      BlocProvider.of<LikeWidgetBloc>(context).add(ToggleLikeWidgetEvent(id: model.id));

  _toDetailPage(BuildContext context, WidgetModel model) {
    // BlocProvider.of<WidgetDetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.push(context, SlidePageRoute(child: WidgetDetailPageScope(model: model)));
  }


}
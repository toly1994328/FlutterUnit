import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router/router_utils.dart';

import 'package:flutter_unit/components/project/no_more_widget.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:flutter_unit/components/project/items/collect_widget_list_item.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';

import '../widget_system_view.dart';

/// create by 张风捷特烈 on 2020/6/16
/// contact me by email 1981462002@qq.com
/// 说明:

class LikeWidgetPage extends StatelessWidget {
  const LikeWidgetPage({Key? key}) : super(key: key);

  final SliverGridDelegate gridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1 / 0.5,
  );

  final SliverGridDelegate deskGridDelegate =
  const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1 / 0.5,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeWidgetBloc, LikeWidgetState>(builder: (ctx, state) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
          ),
          _buildContent(context, state),
          const SliverToBoxAdapter(
            child: NoMoreWidget(),
          )
        ],
      );
    });
  }

  Widget _buildContent(BuildContext context, LikeWidgetState state) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
      sliver: SliverLayoutBuilder(
          builder: (_,c){
            SliverGridDelegate delegate = gridDelegate;
            if(c.crossAxisExtent>500){
              delegate = deskGridDelegate;
            }
            return SliverGrid(
          delegate: SliverChildBuilderDelegate(
              (_, index) => GestureDetector(
                  onTap: () =>
                      _toDetailPage(context, state.widgets[index]),
                  child: CollectWidgetListItem(
                    data: state.widgets[index],
                    onDeleteItemClick: (model) =>
                        _deleteCollect(context, model),
                  )),
              childCount: state.widgets.length),
          gridDelegate: delegate);},
    ));
  }

  _deleteCollect(BuildContext context, WidgetModel model) =>
      BlocProvider.of<LikeWidgetBloc>(context)
          .add(ToggleLikeWidgetEvent(id: model.id));

  _toDetailPage(BuildContext context, WidgetModel model) {
    BlocProvider.of<WidgetDetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.push(context, Right2LeftRouter(child: WidgetDetailPage(model: model)));
  }
}

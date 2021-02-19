import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/views/components/project/no_more_widget.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/components/project/items/collect_widget_list_item.dart';

/// create by 张风捷特烈 on 2020/6/16
/// contact me by email 1981462002@qq.com
/// 说明:

class LikeWidgetPage extends StatelessWidget {

  final SliverGridDelegate gridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
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
          SliverToBoxAdapter(
            child: NoMoreWidget(),
          )
        ],
      );
    });
  }

  Widget _buildContent(BuildContext context, LikeWidgetState state) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
              (_, index) => Container(
                    child: GestureDetector(
                        onTap: () =>
                            _toDetailPage(context, state.widgets[index]),
                        child: CollectWidgetListItem(
                          data: state.widgets[index],
                          onDeleteItemClick: (model) =>
                              _deleteCollect(context, model),
                        )),
                  ),
              childCount: state.widgets.length),
          gridDelegate: gridDelegate),
    );
  }

  _deleteCollect(BuildContext context, WidgetModel model) =>
      BlocProvider.of<LikeWidgetBloc>(context)
          .add(ToggleLikeWidgetEvent(id: model.id));

  _toDetailPage(BuildContext context, WidgetModel model) {
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(context, UnitRouter.widget_detail, arguments: model);
  }
}

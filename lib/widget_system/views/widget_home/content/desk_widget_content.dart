import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_state.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/components/project/items/widget/home_item_support.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';
import 'package:widget_repository/widget_repository.dart';

class DeskWidgetContent extends StatelessWidget {
  final List<WidgetModel> items;
  final double width;

  const DeskWidgetContent({Key? key,required this.items,required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    // final SliverGridDelegateWithFixedCrossAxisCount gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    //   crossAxisCount: 2,
    //   mainAxisSpacing: 10,
    //   crossAxisSpacing: 20,
    //   childAspectRatio: 3.2,
    // );

    SliverGridDelegate gridDelegate =
    const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 400,
      mainAxisSpacing: 10,
      mainAxisExtent: 100,
      crossAxisSpacing: 20,
    );

    return SliverPadding(
      padding: const EdgeInsets.all(15),
      sliver: SliverGrid(
        gridDelegate: gridDelegate,
        delegate: SliverChildBuilderDelegate(
                (_, int index) => _buildHomeItem(items[index]),
            childCount: items.length),
      ),
    );
  }

  Widget _buildHomeItem(WidgetModel model) {
    return BlocBuilder<AppBloc, AppState>(
        buildWhen: (p, c) => (p.itemStyleIndex != c.itemStyleIndex),
        builder: (context, state) {
          int index = state.itemStyleIndex;
          ShapeBorder? shapeBorder = HomeItemSupport.shapeBorderMap[index];
          return InkWell(
              customBorder: shapeBorder,
              onTap: ()=> _toDetail(context,model),
              child: HomeItemSupport.get(model, index));
        },
      );
  }

  //  Widget _buildHomeItem(WidgetModel model) =>
  //       BlocBuilder<GlobalBloc, GlobalState>(
  //         buildWhen: (p, c) => (p.itemStyleIndex != c.itemStyleIndex),
  //         builder: (_, state) {
  //           return FeedbackWidget(
  //               a: 0.95,
  //               duration: const Duration(milliseconds: 200),
  //               onEnd: () => _toDetailPage(model),
  //               child: HomeItemSupport.get(model, state.itemStyleIndex));
  //         },
  //       );

  void _toDetail(BuildContext context,WidgetModel model){
    // BlocProvider.of<WidgetDetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(
      context,
      UnitRouter.widget_detail,
      arguments: model,
    );
  }
}

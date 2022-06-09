import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_state.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/components/project/items/widget/home_item_support.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';
import 'package:flutter_unit/widget_system/repositories/model/widget_model.dart';

class PhoneWidgetContent extends StatelessWidget {
  final List<WidgetModel> items;

  const PhoneWidgetContent({Key? key,required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
              (_, int index) => _buildHomeItem(items[index]),
          childCount: items.length),
    );
  }

  Widget _buildHomeItem(WidgetModel model) =>
      BlocBuilder<GlobalBloc, GlobalState>(
        buildWhen: (p, c) => (p.itemStyleIndex != c.itemStyleIndex),
        builder: (context, state) {
          int index = state.itemStyleIndex;
          ShapeBorder? shapeBorder = HomeItemSupport.shapeBorderMap[index];
          return Padding(
            padding:
            const EdgeInsets.only(bottom: 10, top: 2, left: 10, right: 10),
            child: InkWell(
                customBorder: shapeBorder,
                onTap: ()=> _toDetail(context,model),
                child: HomeItemSupport.get(model, index)),
          );
        },
      );

  void _toDetail(BuildContext context,WidgetModel model){
    BlocProvider.of<WidgetDetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(
      context,
      UnitRouter.widget_detail,
      arguments: model,
    );
  }
}

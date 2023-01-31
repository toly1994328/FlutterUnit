import 'package:app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:old_fancy_mobile_ui/old_fancy_mobile_ui.dart';
import 'package:widget_repository/widget_repository.dart';


class FancyWidgetContent extends StatelessWidget {
  final List<WidgetModel> items;

  const FancyWidgetContent({Key? key,required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) => _buildHomeItem(context, items[index]),
        childCount: items.length,
      ),
    );
  }

  Widget _buildHomeItem(BuildContext context, WidgetModel model) {
        return BlocBuilder<AppBloc, AppState>(
          buildWhen: (p, c) => (p.itemStyleIndex != c.itemStyleIndex),
          builder: (context, state) {
            int index = state.itemStyleIndex;
            ShapeBorder? shapeBorder = HomeItemSupport.shapeBorderMap[index];
            return Padding(
              padding: const EdgeInsets.only(
                  bottom: 10, top: 2, left: 10, right: 10),
              child: InkWell(
                  customBorder: shapeBorder,
                  onTap: () => _toDetail(context, model),
                  child: HomeItemSupport.get(model, index)),
            );
          },
        );

  }

  void _toDetail(BuildContext context, WidgetModel model) {
    Navigator.pushNamed(
      context,
      UnitRouter.widget_detail,
      arguments: model,
    );
  }
}

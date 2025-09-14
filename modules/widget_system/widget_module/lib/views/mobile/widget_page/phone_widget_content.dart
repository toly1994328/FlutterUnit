import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_module/widget_module.dart';

import 'package:widget_repository/widget_repository.dart';
import 'package:widget_ui/widget_ui.dart';

class PhoneWidgetContent extends StatelessWidget {
  final List<WidgetModel> items;

  const PhoneWidgetContent({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) => Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
          child: WidgetItem(
            model: items[index],
            onWidget: context.handleWidgetAction,
          ),
        ),
        childCount: items.length,
      ),
    );
  }

  void _toDetail(BuildContext context, WidgetModel model) {
    context.push('/widget/detail/${model.name}', extra: model);
  }
}

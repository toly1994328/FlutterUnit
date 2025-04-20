import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:widget_repository/widget_repository.dart';

import 'mobile_widget_tiled.dart';



class PhoneWidgetContent extends StatelessWidget {
  final List<WidgetModel> items;

  const PhoneWidgetContent({Key? key,required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) => MobileWidgetTiled(
          model:  items[index],
          onTap: () => _toDetail(context,  items[index]),
        ),
        childCount: items.length,
      ),
    );
  }

  void _toDetail(BuildContext context, WidgetModel model) {
    context.push('/widget/detail/${model.name}',extra: model);

  }
}

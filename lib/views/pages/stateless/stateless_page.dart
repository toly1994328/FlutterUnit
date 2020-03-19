import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_event.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/items/widget_list_item.dart';

class WidgetPage extends StatelessWidget {

  final List<WidgetModel> items;

  WidgetPage(this.items); //  WidgetPage(items);

  @override
  Widget build(BuildContext context) {

      return ListView.separated(
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: InkWell(
                onTap: () {
                  BlocProvider.of<DetailBloc>(context).add(ToWidgetDetail(items[index]));
                  Navigator.pushNamed(context, Router.widget_detail);
                },
                child: WidgetListItem(
                  data: items[index],
                )),
          ),
          separatorBuilder: (_, index) => Container(),
          itemCount: items.length);
    }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_event.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/items/widget_list_item.dart';

class WidgetPage extends StatefulWidget {

  final List<WidgetModel> items;

  WidgetPage(this.items);
  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  @override
  void initState() {
    print('initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

      return ListView.separated(
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: InkWell(
                onTap: () {
                  BlocProvider.of<DetailBloc>(context).add(ToWidgetDetail(widget.items[index]));
                  Navigator.pushNamed(context, Router.widget_detail);
                },
                child: WidgetListItem(
                  data: widget.items[index],
                )),
          ),
          separatorBuilder: (_, index) => Container(),
          itemCount: widget.items.length);
    }
}

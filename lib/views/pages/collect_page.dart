

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/collect/collect_bloc.dart';
import 'package:flutter_unit/blocs/collect/collect_event.dart';
import 'package:flutter_unit/blocs/collect/collect_state.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_event.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/items/collect_widget_list_item.dart';
import 'package:flutter_unit/views/items/techno_widget_list_item.dart';

import '../empty_page.dart';

class CollectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('收藏集'),),
      body: BlocBuilder<CollectBloc, CollectState>(
              builder: (_, state) {
                return GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: state.widgets.length,
                   itemBuilder: (_, index) => Container(
                  child: GestureDetector(
                      onTap: () => _toDetailPage(context,state.widgets[index]),
                      child: CollectWidgetListItem(
                        data: state.widgets[index],
                      )),
                ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio:1/0.5,),
                );
              }
      ),
    );
  }

  _toDetailPage(BuildContext context,WidgetModel model){
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(context, Router.widget_detail);
  }
}

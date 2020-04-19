import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/collect/collect_bloc.dart';
import 'package:flutter_unit/blocs/collect/collect_event.dart';
import 'package:flutter_unit/blocs/collect/collect_state.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_event.dart';
import 'package:flutter_unit/blocs/widgets/home_bloc.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/items/collect_widget_list_item.dart';

class DefaultCollectPage extends StatelessWidget {
  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1 / 0.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BlocProvider.of<HomeBloc>(context).state.homeColor,
        title: Text('收藏集'),
        actions: <Widget>[_buildAddActionBuilder(context)],
      ),
      body: BlocBuilder<CollectBloc, CollectState>(builder: (_, state) {
        return GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: state.widgets.length,
          itemBuilder: (_, index) => Container(
            child: GestureDetector(
                onTap: () => _toDetailPage(context, state.widgets[index]),
                child: CollectWidgetListItem(
                  data: state.widgets[index],
                  onDelectItemClick: (model) => _deleteCollect(context, model),
                )),
          ),
          gridDelegate: gridDelegate,
        );
      }),
    );
  }

  Widget _buildAddActionBuilder(BuildContext context) => IconButton(
      icon: Icon(
        Icons.add,
        size: 30,
      ),
      onPressed: () => Scaffold.of(context).openEndDrawer());


  _deleteCollect(BuildContext context, WidgetModel model) =>
      BlocProvider.of<CollectBloc>(context)
          .add(ToggleCollectEvent(id: model.id));

  _toDetailPage(BuildContext context, WidgetModel model) {
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(context, Router.widget_detail, arguments: model);
  }
}

import 'package:artifact/artifact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresh/refresh.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'widget_list_panel.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({Key? key}) : super(key: key);

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color themeColor = Color(0xff007ACB);

    return BlocListener<WidgetsBloc,WidgetsState>(
      listener: _listenStateChange,
      child: RefreshConfigWrapper(
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          enablePullUp: true,
          onLoading: _onLoadMore,
          child: CustomScrollView(

            // key: PageStorageKey<String>(name),
            slivers: <Widget>[

              const WidgetListPanel(),

            ],
          ),
        ),
      ),
    );
  }

  void _onRefresh() async{
    context.read<WidgetsBloc>().add(EventRefresh());
  }

  void _onLoadMore() {
    context.read<WidgetsBloc>().add(EventLoadMore());
  }

  void _listenStateChange(BuildContext context, WidgetsState state) async{
    if (state is WidgetsLoaded) {
      if (state.operate == LoadOperate.refresh) {
        _refreshController.refreshCompleted();
      }
      if (state.operate == LoadOperate.more) {
        if (state.full) {
          _refreshController.loadNoData();
          await Future.delayed(const Duration(milliseconds: 2000));
          _refreshController.resetNoData();
        } else {
          _refreshController.loadComplete();
        }
      }
    }
  }
}

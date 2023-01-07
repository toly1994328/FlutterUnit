import 'package:app_config/app_config.dart';
import 'package:db_storage/db_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/plateform_adapter/window/windows_adapter.dart';
import 'package:flutter_unit/app/utils/convert.dart';
import 'package:flutter_unit/components/permanent/decorations/round_rect_rab_indicator.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:window_manager/window_manager.dart';

import 'desk_widget_model_item.dart';
import 'desk_search_bar.dart';
import 'desk_widget_top_bar.dart';
import 'window_buttons.dart';

class DeskWidgetPanel extends StatefulWidget {
  const DeskWidgetPanel({Key? key}) : super(key: key);

  @override
  State<DeskWidgetPanel> createState() => _DeskWidgetPanelState();
}

class _DeskWidgetPanelState extends State<DeskWidgetPanel>{

  @override
  Widget build(BuildContext context) {
    WidgetsState state = context.watch<WidgetsBloc>().state;

    return Scaffold(
      body: Column(
        children: [
          DeskWidgetTopBar(
            onTabPressed: _switchTab,
          ),
          const Divider(height: 1),
          Expanded(
            child: _buildByState(state),
          ),
        ],
      ),
    );
  }

  Widget _buildByState(WidgetsState state) {
    if (state is WidgetsLoaded) {
      return WidgetList(state: state);
    }
    return Center(
      child: Text("${state.runtimeType}"),
    );
  }

  void _switchTab(int index) {
    WidgetFamily widgetFamily = Convert.toFamily(index);
    BlocProvider.of<WidgetsBloc>(context).add(EventTabTap(widgetFamily));
  }
}

class WidgetList extends StatelessWidget {
  final WidgetsLoaded state;

  const WidgetList({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SliverGridDelegate gridDelegate =
        const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 400,
      mainAxisSpacing: 10,
      mainAxisExtent: 130,
      crossAxisSpacing: 10,
    );

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      gridDelegate: gridDelegate,
      itemBuilder: _buildItem,
      itemCount: state.widgets.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    WidgetModel model = state.widgets[index];
    return DeskWidgetItem(
      model: model,
      onTap: () {
        Navigator.pushNamed(
          context,
          UnitRouter.widget_detail,
          arguments: model,
        );
      },
    );
  }
}

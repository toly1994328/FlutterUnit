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
import 'window_buttons.dart';

class DeskWidgetPanel extends StatefulWidget {
  const DeskWidgetPanel({Key? key}) : super(key: key);

  @override
  State<DeskWidgetPanel> createState() => _DeskWidgetPanelState();
}

class _DeskWidgetPanelState extends State<DeskWidgetPanel> with SingleTickerProviderStateMixin{

  late TabController tabController;
  static const List<String> _tabs = ['无态', '有态', '单渲', '多渲', '滑片', '代理', '其它'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsState state = context.watch<WidgetsBloc>().state;
    Color themeColor = Theme.of(context).primaryColor;

    return Scaffold(
      body:  Column(
        children: [
          DragToMoveAreaNoDouble(
            child: Container(
              height: 64,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: TabBar(
                    onTap: _switchTab,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                    isScrollable: false,
                    indicator: RoundRectTabIndicator(
                      borderSide: BorderSide(color: themeColor, width: 3),
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: tabController,
                    labelColor: themeColor,
                    indicatorWeight: 3,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: themeColor,
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(width: 250, height: 30, child: DeskSearchBar()),
                  ),
                  // const SizedBox(width: 20,),
                  WindowButtons(),
                  const SizedBox(width: 20,),
                ],
              ),
            ),
          ),
          Divider(height: 1,),
          Expanded(
            child: _buildByState(state),
          ),
        ],
      ),
    );
  }

  Widget _buildByState(WidgetsState state) {
    if(state is WidgetsLoaded){
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

  const WidgetList({Key? key,required this.state}) : super(key: key);

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
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      gridDelegate: gridDelegate,
        itemBuilder: _buildItem,
      itemCount: state.widgets.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    WidgetModel model = state.widgets[index];
    return DeskWidgetItem(
      model: model,
      onTap: (){
        Navigator.pushNamed(
          context,
          UnitRouter.widget_detail,
          arguments: model,
        );
      },
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/components/project/default/empty_shower.dart';
import 'package:flutter_unit/components/project/default/loading_shower.dart';
import 'package:flutter_unit/widget_system/blocs/widget_detail_bloc/widget_detail_bloc.dart';
import 'package:flutter_unit/widget_system/blocs/widget_detail_bloc/widget_detail_event.dart';
import 'package:flutter_unit/widget_system/blocs/widgets_bloc/widgets_bloc.dart';
import 'package:flutter_unit/widget_system/blocs/widgets_bloc/widgets_state.dart';
import 'package:flutter_unit/widget_system/views/search_view/empty_search_page.dart';
import 'package:flutter_unit/widget_system/views/search_view/error_page.dart';
import 'package:flutter_unit/widget_system/views/standard_widget_home/standard_item/widget_model_item.dart';
import 'package:flutter_unit/widget_system/views/standard_widget_home/search_page/standard_search_bar.dart';
import 'package:widget_repository/widget_repository.dart';

// SearchPage 可以复用 WidgetsBloc，进行局部的 Bloc
// 不必单独提供 SearchBloc 增加复杂性
class StandardSearchPageProvider extends StatelessWidget {
  const StandardSearchPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => WidgetsBloc(
        repository: BlocProvider.of<WidgetsBloc>(context).repository,
      ),
      child: const StandardSearchPage(),
    );
  }
}

class StandardSearchPage extends StatelessWidget {
  const StandardSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top,width:MediaQuery.of(context).size.width,child: const ColoredBox(color: Colors.white),),
          const StandardSearchBarInner(),
          Expanded(child:           BlocBuilder<WidgetsBloc, WidgetsState>(builder: _buildBodyByState))
        ],
      ),
    );
  }

  Widget _buildBodyByState(BuildContext context, WidgetsState state) {
    Widget noSearchArg = const NotSearchPage();
    if (state.filter.name.isEmpty) {
      return noSearchArg;
    }

    if(state is WidgetsLoaded){
      if (state.widgets.isEmpty) {
        return const EmptyShower(
          message: "没数据，哥也没办法\n(≡ _ ≡)/~┴┴",
        );
      }
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (_,index)=>StandardWidgetItem(
            searchArg: state.filter.name,
            model: state.widgets[index], onTap: ()=> _toDetail(context, state.widgets[index])),itemCount: state.widgets.length,);
    }



    if (state is WidgetsLoading) {
      return const LoadingShower();
    }

    if (state is WidgetsLoadFailed) {
      return const ErrorPage();
    }

    return noSearchArg;

  }

  void _toDetail(BuildContext context,WidgetModel model){
    // BlocProvider.of<WidgetDetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(
      context,
      UnitRouter.widget_detail,
      arguments: model,
    );
  }
}

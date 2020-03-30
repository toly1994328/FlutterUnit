import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/style/TolyIcon.dart';
import 'package:flutter_unit/blocs/search/search_bloc.dart';
import 'package:flutter_unit/blocs/search/search_state.dart';
import 'package:flutter_unit/views/pages/search/app_search_bar.dart';
import 'package:flutter_unit/views/pages/search/error_page.dart';
import 'package:flutter_unit/views/pages/search/loading_page.dart';
import 'package:flutter_unit/views/pages/search/not_search_page.dart';

import '../empty_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(TolyIcon.icon_star_add),
          )
        ],
        title: AppSearchBar(),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
          builder: (_, state) => _buildBodyByState(state)),
    );
  }

  _buildBodyByState(SearchState state) {
    if (state is SearchStateNoSearch) return NotSearchPage();
    if (state is SearchStateLoading) return LoadingPage();
    if (state is SearchStateError) return ErrorPage();
//    if (state is SearchStateSuccess) return FillPage(state.result);
    if (state is SearchStateEmpty) return EmptyPage();
  }
}

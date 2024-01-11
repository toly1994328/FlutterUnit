import 'package:app/app.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toly_ui/toly_ui.dart';

import 'package:widget_module/blocs/blocs.dart';


import '../../../data/exp.dart';
import '../widget_page/unit_drawer_header.dart';


/// create by 张风捷特烈 on 2020-04-22
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryEndDrawer extends StatelessWidget {
  final WidgetModel widget;

  const CategoryEndDrawer({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        UnitDrawerHeader(color: Theme.of(context).primaryColor),
        Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Circle(
            color: widget.color,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(widget.name)
        ],
      ),
        ),
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Panel(
        child: Text(widget.info, style: UnitTextStyle.shadowTextStyle),
      ),
        ),
        const Divider(),
        _buildTitle(context),
        const Divider(),
        CategoryInfo(widget.id)
      ]),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Circle(
            color: Theme.of(context).primaryColor,
            radius: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '当前组件收藏情况',
              style: TextStyle(fontSize: 16, shadows: [
                Shadow(
                    color: Colors.white, offset: Offset(.5, .5), blurRadius: 1)
              ]),
            ),
          ),
          Circle(
            color: Theme.of(context).primaryColor,
            radius: 5,
          ),
        ],
      ),
    );
  }
}

class CategoryInfo extends StatefulWidget {
  final int id;

  const CategoryInfo(this.id, {Key? key}) : super(key: key);

  @override
  _CategoryInfoState createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  List<int> categoryIds = [];
  List<CategoryModel> _categories = [];

  @override
  void didChangeDependencies() {
    _loadCategoryIds();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 4,
        runSpacing: 8,
        children: categories.map((e) => _buildItem(e)).toList(),
      ),
    );
  }

  Widget _buildItem(CategoryModel category) {
    bool inHere = categoryIds.contains(category.id);
    return FilterChip(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(33),
        selectedColor: Colors.orange.withAlpha(120),
        shadowColor: Theme.of(context).primaryColor,
        elevation: 1,
        // labelPadding: const EdgeInsets.only(right: 4,left: 4),
        avatar: Circle(
          radius: 10,
          color: category.color,
        ),
        selected: inHere,
        label: Text(category.name),
        onSelected: (v) async {
          await repository.toggleCategory(category.id!, widget.id);
          _loadCategoryIds();
          BlocProvider.of<CategoryWidgetBloc>(context).add(EventLoadCategoryWidget(category.id!));
        });
  }

  CategoryRepository get repository =>
      BlocProvider.of<CategoryBloc>(context).repository;

  List<CategoryModel> get categories {
    CategoryState state = BlocProvider.of<CategoryBloc>(context).state;
    if (state is CategoryLoadedState) {
      _categories = state.categories;
    }
    return _categories;
  }

  void _loadCategoryIds() async {
    categoryIds = await repository.getCategoryByWidget(widget.id);
    if (mounted) setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/category/category_bloc.dart';
import 'package:flutter_unit/blocs/category/category_event.dart';
import 'package:flutter_unit/blocs/category/category_state.dart';
import 'package:flutter_unit/blocs/collect/collect_bloc.dart';
import 'package:flutter_unit/blocs/collect/collect_event.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_event.dart';
import 'package:flutter_unit/blocs/widgets/home_bloc.dart';
import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/dialogs/delete_category_dialog.dart';
import 'package:flutter_unit/views/items/category_list_item.dart';

class CategoryPage extends StatelessWidget {
  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 0.8,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (_, state) {
        if (state is CategoryLoadedState) {
          return GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: state.categories.length,
            itemBuilder: (_, index) => Container(
              child: GestureDetector(
                  onTap: () => _toDetailPage(context, state.categories[index]),
                  child: CategoryListItem(
                    data: state.categories[index],
                    onDeleteItemClick: (model) =>
                        _deleteCollect(context, model),
                  )),
            ),
            gridDelegate: gridDelegate,
          );
        }
        return Container();
      });
  }

  _deleteCollect(BuildContext context, CategoryModel model) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
              backgroundColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                width: 50,
                child: DeleteCategoryDialog(
                  title: '删除收藏集',
                  content: '    删除【${model.name}】收藏集，你将会失去其中的所有收藏组件，是否确定继续执行?',
                  onSubmit: () {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(EventDeleteCategory(id: model.id));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ));
  }

  _toDetailPage(BuildContext context, CategoryModel model) {
//    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(model));
//    Navigator.pushNamed(context, Router.widget_detail, arguments: model);
  }
}

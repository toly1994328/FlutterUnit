import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/components/permanent/circle.dart';

import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/views/dialogs/delete_category_dialog.dart';
import 'package:flutter_unit/views/items/category_list_item.dart';

import 'edit_category_panel.dart';

class CategoryPage extends StatelessWidget {

  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 0.8,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (ctx, state) {
      if (state is CategoryLoadedState) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            ),
            _buildContent(context, state)],
        );
      }
      return Container();
    });
  }

  _buildContent(BuildContext context, CategoryLoadedState state) {
    return SliverPadding(
      padding: EdgeInsets.only(top:10, left: 10, right: 10, bottom: 40),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
                  (_, index) => Container(
                child: GestureDetector(
                    onTap: () => _toDetailPage(context, state.categories[index]),
                    child:  CategoryListItem(
                      data: state.categories[index],
                      onDeleteItemClick: (model) => _deleteCollect(context, model),
                      onEditItemClick: (model) => _editCollect(context, model),
                    )),
              ),
              childCount: state.categories.length),
          gridDelegate: gridDelegate),
    );
  }

  _deleteCollect(BuildContext context, CategoryModel model) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
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

  _editCollect(BuildContext context, CategoryModel model) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
              backgroundColor:Color(0xFFF2F2F2),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Circle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        '修改收藏集',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      CloseButton()
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EditCategoryPanel(model: model,type: EditType.update,),
                  ),
                ],
              ),
            ));
  }

  _toDetailPage(BuildContext context, CategoryModel model) {
    BlocProvider.of<CategoryWidgetBloc>(context)
        .add(EventLoadCategoryWidget(model.id));
    Navigator.pushNamed(context, UnitRouter.category_show, arguments: model);
  }


}

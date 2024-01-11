import 'package:app/app.dart';
import 'package:components/project_ui/project_ui.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:widget_module/blocs/blocs.dart';

import '../../../data/exp.dart';


import 'category_list_item.dart';
import 'delete_category_dialog.dart';
import 'edit_category_panel.dart';
import 'empty_category.dart';

class CategoryPage extends StatelessWidget {
  final SliverGridDelegateWithMaxCrossAxisExtent gridDelegate =
      const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 200,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
    // crossAxisCount: 2,

    // childAspectRatio: 0.8,
  );

  final SliverGridDelegateWithFixedCrossAxisCount deskGridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 0.9,
  );
  
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (ctx, state) {
      if (state is CategoryLoadedState) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            ),
            _buildContent(context, state),
          ],
        );
      }
      if (state is CategoryLoadingState) return const LoadingShower();
      return const EmptyCategory();
    });
  }

  _buildContent(BuildContext context, CategoryLoadedState state) {
    double bottom = MediaQuery.of(context).padding.bottom;

    return SliverPadding(
      padding:  EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20+bottom),
      sliver: SliverLayoutBuilder(
          builder: (_,c){
            SliverGridDelegate delegate = gridDelegate;
            if(c.crossAxisExtent>500){
              delegate = deskGridDelegate;
            }
            return SliverGrid(
            delegate: SliverChildBuilderDelegate(
                (_, index) => GestureDetector(
                    onTap: () =>
                        _toDetailPage(context, state.categories[index]),
                    child: CategoryListItem(
                      data: state.categories[index],
                      onDeleteItemClick: (model) =>
                          _deleteCollect(context, model),
                      onEditItemClick: (model) =>
                          _editCollect(context, model),
                    )),
                childCount: state.categories.length),
            gridDelegate: delegate); }
      ),
    );
  }

  ShapeBorder get rRectBorder => const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)));

  void _deleteCollect(BuildContext context, CategoryModel model) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
              elevation: 5,
              shape: rRectBorder,
              child: SizedBox(
                width: 50,
                child: DeleteCategoryDialog(
                  title: '删除收藏集',
                  content: '    删除【${model.name}】收藏集，你将会失去其中的所有收藏组件，是否确定继续执行?',
                  onSubmit: () {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(EventDeleteCategory(id: model.id!));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ));
  }

  void _editCollect(BuildContext context, CategoryModel model) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
              backgroundColor: const Color(0xFFF2F2F2),
              elevation: 5,
              shape: rRectBorder,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Gap.H5,
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Circle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const Text(
                        '修改收藏集',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      const CloseButton()
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

  void _toDetailPage(BuildContext context, CategoryModel model) {
    BlocProvider.of<CategoryWidgetBloc>(context).add(EventLoadCategoryWidget(model.id!));
    context.push('/collection_widgets/${model.id}',extra: model);
  }


}

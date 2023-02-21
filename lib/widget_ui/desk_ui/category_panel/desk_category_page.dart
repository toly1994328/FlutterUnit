import 'package:app_config/app/style/gap.dart';
import 'package:app_config/app_config.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';

import '../../../components/top_bar/desk_tab_top_bar.dart';
import '../../mobile/category_page/category_list_item.dart';
import '../../mobile/category_page/delete_category_dialog.dart';
import '../../mobile/category_page/edit_category_panel.dart';
import '../../mobile/category_page/like_widget_page.dart';
import 'desk_top_like_panel.dart';

class DeskCategoryPage extends StatefulWidget {
  const DeskCategoryPage({Key? key}) : super(key: key);

  @override
  State<DeskCategoryPage> createState() => _DeskCategoryPageState();
}

class _DeskCategoryPageState extends State<DeskCategoryPage> {

  final PageController _ctrl = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DeskTabTopBar(onTabPressed: (int value) {
            _ctrl.jumpToPage(value);
          }, tabs: ['收藏记录','珍藏组件',
            // '添加收藏集'
          ],),
              Expanded(child: PageView(
                controller: _ctrl,
                children: [
                  DeskCateGoryPage(),
                  DeskLikePage(),
                ],
              ))
        ],
      ),
    );
  }
}

class DeskCateGoryPage extends StatelessWidget {
  const DeskCateGoryPage({Key? key}) : super(key: key);

  final SliverGridDelegate deskGridDelegate =
  const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 300,
    mainAxisSpacing: 10,
    mainAxisExtent: 260,
    crossAxisSpacing: 10,
  );

  @override
  Widget build(BuildContext context) {

    CategoryBloc bloc =  context.read<CategoryBloc>();
    CategoryState state = bloc.state;
    if(state is CategoryLoadedState){
      return GridView.builder(
        itemCount: state.categories.length,
          padding: EdgeInsets.all(20),
          gridDelegate: deskGridDelegate, itemBuilder:  (_, index) => GestureDetector(
          onTap: () => _toDetailPage(context, state.categories[index]),
          child: CategoryListItem(
            data: state.categories[index],
            onDeleteItemClick: (model) =>
                _deleteCollect(context, model),
            onEditItemClick: (model) =>
                _editCollect(context, model),
          )));
    }

    return SizedBox.shrink();

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
    Navigator.pushNamed(context, UnitRouter.category_show, arguments: model);
  }


}

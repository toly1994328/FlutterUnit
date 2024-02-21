
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:go_router/go_router.dart';

import 'package:widget_module/blocs/blocs.dart';

import '../../../data/exp.dart';


/// create by 张风捷特烈 on 2020-04-22
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryShow extends StatelessWidget {
  final CategoryModel model;

  const CategoryShow({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryWidgetState state = context.watch<CategoryWidgetBloc>().state;
    Widget child = const SizedBox();
    if (state is CategoryWidgetLoadedState) {
      child =  _buildWidgetList(state.widgets);
    }
    return Scaffold(
      appBar: AppBar(title: Text(model.name)),
      body: child,
    );
  }

  Widget _buildWidgetList(List<WidgetModel> widgets) {
    return ListView.separated(
        separatorBuilder: (_, index) => const Divider(height: 1),
        itemBuilder: (context, index) => Dismissible(
              direction: DismissDirection.endToStart,
              key: ValueKey(widgets[index].id),
              background: Container(
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Icon(
                  CupertinoIcons.delete_solid,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              onDismissed: (v) {
                BlocProvider.of<CategoryWidgetBloc>(context).add(
                    EventToggleCategoryWidget(model.id!, widgets[index].id));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: FeedbackWidget(
                    duration: const Duration(milliseconds: 200),
                    onPressed: () => _toDetailPage(context, widgets[index]),
                    child:
                        // Container(height: 60,)
                        SimpleWidgetItem(
                      data: widgets[index],
                    )),
              ),
            ),
        itemCount: widgets.length);
  }

 void _toDetailPage(BuildContext context, WidgetModel model) async {
    // Navigator.pushNamed(context, UnitRouter.widget_detail, arguments: model);
    context.push('/widget/detail/${model.name}',extra: model);
  }
}

class SimpleWidgetItem extends StatelessWidget {
  final WidgetModel data;

  const SimpleWidgetItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
Color shadowColor = isDark?Colors.black:Colors.white;
    return Container(
      height: 64,
      child: Row(
        children: <Widget>[
          _buildLeading(shadowColor),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[_buildTitle(shadowColor), _buildSummary(shadowColor)],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(Color shadowColor) {
    return Row(
      children: [
        Expanded(
          child: Text(data.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: shadowColor, offset: Offset(.3, .3))
                  ])),
        ),
        const SizedBox(width: 15),
        StarScore(
          star: Star(emptyColor: shadowColor, size: 12, fillColor: data.color),
          score: data.lever,
        )
      ],
    );
  }

  Widget _buildLeading(Color shadowColor) => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: data.image == null
            ? Material(
                color: Colors.transparent,
                child: CircleText(

                  text: data.name,
                  size: 50,
                  color: data.color,
                ),
              )
            : CircleImage(
                image: data.image!,
                size: 50,
              ),
      );

  Widget _buildSummary(Color shadowColor) {
    return Text(
      data.info,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style:  TextStyle(
          color: Color(0xFF757575),
          fontSize: 12,
          shadows: [Shadow(color: shadowColor, offset: Offset(.5, .5))]),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/views/components/permanent/circle_image.dart';
import 'package:flutter_unit/views/components/permanent/circle_text.dart';
import 'package:flutter_unit/views/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/model/widget_model.dart';

/// create by 张风捷特烈 on 2020-04-22
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryShow extends StatelessWidget {
  final CategoryModel model;

  CategoryShow({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(model.name)),
      body: BlocBuilder<CategoryWidgetBloc, CategoryWidgetState>(
          builder: (_, state) {
        if (state is CategoryWidgetLoadedState) {
          return _buildWidgetList(state.widgets);
        }
        return const SizedBox();
      }),
    );
  }

  Widget _buildWidgetList(List<WidgetModel> widgets) {
    return ListView.separated(
        separatorBuilder: (_, index) => const Divider(height: 1),
        itemBuilder: (context, index) => Dismissible(
              direction: DismissDirection.endToStart,
              key: ValueKey(widgets[index].id),
              background: Container(
                padding: EdgeInsets.only(right: 20),
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
                    EventToggleCategoryWidget(model.id, widgets[index].id));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: FeedbackWidget(
                    duration: Duration(milliseconds: 200),
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

  _toDetailPage(BuildContext context, WidgetModel model) async {
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(context, UnitRouter.widget_detail, arguments: model);
  }
}

class SimpleWidgetItem extends StatelessWidget {
  final WidgetModel data;

  SimpleWidgetItem({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 75,
      child: Row(
        children: <Widget>[
          _buildLeading(),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[_buildTitle(), _buildSummary()],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Text(data.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(color: Colors.white, offset: Offset(.3, .3))
                ])),
        const SizedBox(width: 15),
        StarScore(
          star: Star(emptyColor: Colors.white, size: 12, fillColor: data.color),
          score: data.lever,
        )
      ],
    );
  }

  Widget _buildLeading() => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: data.image == null
            ? Material(
                color: Colors.transparent,
                child: CircleText(
                  text: data.name,
                  size: 60,
                  color: data.color,
                ),
              )
            : CircleImage(
                image: data.image,
                size: 60,
              ),
      );

  Widget _buildSummary() {
    return Text(
      data.info,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          color: Color(0xFF757575),
          fontSize: 14,
          shadows: [Shadow(color: Colors.white, offset: Offset(.5, .5))]),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/category_widget/category_widget_bloc.dart';
import 'package:flutter_unit/blocs/category_widget/category_widget_event.dart';
import 'package:flutter_unit/blocs/category_widget/category_widget_state.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_event.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/circle_text.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/items/techno_widget_list_item.dart';

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
        return Container();
      }),
    );
  }

  Widget _buildWidgetList(List<WidgetModel> widgets) {
    return ListView.separated(
        separatorBuilder: (_, index) => Divider(
              height: 1,
            ),
        itemBuilder: (context, index) => Dismissible(
              direction: DismissDirection.endToStart,
              key: ValueKey(widgets[index].id),
              background: Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Icon(
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
                    child: SimpleWidgetItem(
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
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildLeading(),
              StarScore(
                star: Star(
                    emptyColor: Colors.white, size: 12, fillColor: data.color),
                score: data.lever,
              ),
            ],
          ),
          SizedBox(
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
    return Text(data.name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.white, offset: Offset(.3, .3))]));
  }

  Widget _buildLeading() => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Hero(
          tag: "hero_widget_image_${data.id}",
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
                  image: data.image,
                  size: 50,
                ),
        ),
      );

  Widget _buildSummary() {
    return Container(
      child: Text(
        data.info,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            shadows: [Shadow(color: Colors.white, offset: Offset(.5, .5))]),
      ),
    );
  }
}

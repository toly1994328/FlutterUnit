import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/style/shape/techno_shape.dart';
import 'package:flutter_unit/blocs/collect/collect_bloc.dart';
import 'package:flutter_unit/blocs/collect/collect_state.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/circle_text.dart';
import 'package:flutter_unit/components/permanent/tag.dart';
import 'package:flutter_unit/model/widget_model.dart';

class TechnoWidgetListItem extends StatelessWidget {
  final WidgetModel data;

  TechnoWidgetListItem({this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Material(
          color: itemColor.withAlpha(66),
          shape: TechnoShapeBorder(color: itemColor),
          child: Container(
            height: 95,
            padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
            child: Row(
              children: <Widget>[
                Wrap(
                  spacing: 5,
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    _buildLeading(),
                    StarScore(
                      star: Star(
                          emptyColor: Colors.white,
                          size: 12,
                          fillColor: itemColor),
                      score: data.lever,
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[_buildTitle(), _buildSummary()],
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildCollectTag(Theme.of(context).primaryColor)
      ],
    );
  }

  Widget _buildCollectTag(Color color) {
    return Positioned(
        top: 0,
        right: 40,
        child: BlocBuilder<CollectBloc, CollectState>(builder: (_, s) {
          var show = s.widgets.contains(data);
          return Opacity(
            opacity: show ? 1.0 : 0.0,
            child: SizedOverflowBox(
              alignment: Alignment.bottomCenter,
              size: Size(0, 30 - 8.0),
              child: Tag(
                color: color,
                shadowHeight: 8.0,
                size: Size(20, 30),
              ),
            ),
          );
        }));
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
                    size: 60,
                    color: itemColor,
                  ),
                )
              : CircleImage(
                  image: data.image,
                  size: 55,
                ),
        ),
      );

  Color get itemColor => Color(Cons.tabColors[data.family.index]);

  Widget _buildTitle() {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        Expanded(
          child: Text(data.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: Colors.white, offset: Offset(.3, .3))
                  ])),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        //尾部摘要
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

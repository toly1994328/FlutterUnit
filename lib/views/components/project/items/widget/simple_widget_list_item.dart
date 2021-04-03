import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/views/components/permanent/circle_image.dart';
import 'package:flutter_unit/views/components/permanent/circle_text.dart';
import 'package:flutter_unit/views/components/permanent/tag.dart';
import 'package:flutter_unit/model/widget_model.dart';

/// create by 张风捷特烈 on 2020/11/17
/// contact me by email 1981462002@qq.com
/// 说明:

class SimpleWidgetListItem extends StatelessWidget {
  final WidgetModel data;

  SimpleWidgetListItem({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          color: itemColor.withAlpha(66),
        borderRadius: BorderRadius.circular(6)
      ),
      margin: const EdgeInsets.only(bottom: 10,top:2,left: 10,right: 10),
      child: Stack(
        children: <Widget>[
          Container(
            height: 95,
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
            child: Row(
              children: <Widget>[
                Wrap(
                  spacing: 5,
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Hero(
                        tag: "hero_widget_image_${data.id}",
                        child: _buildLeading()),
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
          _buildCollectTag(Theme.of(context).primaryColor)
        ],
      ),
    );
  }

  Widget _buildCollectTag(Color color) {
    return Positioned(
        top: 0,
        right: 40,
        child: BlocBuilder<LikeWidgetBloc, LikeWidgetState>(builder: (_, s) {
          bool show = s.widgets.contains(data);
          return Opacity(
            opacity: show ? 1.0 : 0.0,
            child: SizedOverflowBox(
              alignment: Alignment.bottomCenter,
              size: const Size(0, 30 - 8.0),
              child: Tag(
                color: color,
                shadowHeight: 8.0,
                size: const Size(20, 30),
              ),
            ),
          );
        }));
  }

  Widget _buildLeading() => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
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
      );

  Color get itemColor => Color(Cons.tabColors[data.family.index]);

  Widget _buildTitle() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: Text(data.name,
              overflow: TextOverflow.ellipsis,
              style:  TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  decoration: (data.deprecated)?TextDecoration.lineThrough:TextDecoration.none,
                  decorationThickness: 2,
                  shadows: [
                    Shadow(color: Colors.white, offset: Offset(.3, .3))
                  ])),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        //尾部摘要
        data.info,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey[600], fontSize: 14, shadows: [
          const Shadow(color: Colors.white, offset: const Offset(.5, .5))
        ]),
      ),
    );
  }
}

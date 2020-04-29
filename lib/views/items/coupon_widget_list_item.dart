import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/style/shape/coupon_shape_border.dart';
import 'package:flutter_unit/blocs/collect/collect_bloc.dart';
import 'package:flutter_unit/blocs/collect/collect_state.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/circle_text.dart';
import 'package:flutter_unit/components/permanent/tag.dart';
import 'package:flutter_unit/model/widget_model.dart';

class CouponWidgetListItem extends StatelessWidget {
  final WidgetModel data;
  final bool hasTopHole;
  final bool hasBottomHole;
  final bool isClip;

  CouponWidgetListItem(
      {this.data,
      this.hasTopHole = true,
      this.hasBottomHole = false,
      this.isClip = true});

  final List<int> colors = Cons.tabColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Stack(
        children: <Widget>[
          isClip
              ? ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: CouponShapeBorder(
                          hasTopHole: hasTopHole,
                          hasBottomHole: hasBottomHole,
                          hasLine: false,
                          edgeRadius: 25,
                          lineRate: 0.20)),
                  child: buildContent(),
                )
              : buildContent(),
          _buildCollectTag(Theme.of(context).primaryColor)
        ],
      ),
    );
  }

  Widget buildContent() => Container(
        color: Color(colors[data.family.index]).withAlpha(66),
        height: 95,
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
        child: Row(
          children: <Widget>[
            buildLeading(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[_buildTitle(), _buildSummary()],
              ),
            ),
          ],
        ),
      );

  Widget buildLeading() => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Hero(
          tag: "hero_widget_image_${data.id}",
          child: data.image == null
              ? Material(
                  color: Colors.transparent,
                  child: CircleText(
                    text: data.name,
                    size: 60,
                    color: invColor,
                  ),
                )
              : CircleImage(
                  image: data.image,
                  size: 60,
                ),
        ),
      );

  Color get invColor {
    return Color(colors[data.family.index]);
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
              size: const Size(0, 20 - 6.0),
              child: Tag(
                color: color,
                shadowHeight: 6.0,
                size: const Size(15, 20),
              ),
            ),
          );
        }));
  }

  Widget _buildTitle() {
    return Expanded(
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          Expanded(
            child: Text(data.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: Colors.white, offset: Offset(.3, .3))
                    ])),
          ),
          StarScore(
            star: Star(emptyColor: Colors.white, size: 15, fillColor: invColor),
            score: data.lever,
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
      child: Container(
        child: Text(
          //尾部摘要
          data.info,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey[600], fontSize: 14, shadows: [
            const Shadow(color: Colors.white, offset: const Offset(.5, .5))
          ]),
        ),
      ),
    );
  }
}

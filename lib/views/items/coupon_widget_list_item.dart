import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/style/shape/coupon_shape_border.dart';
import 'package:flutter_unit/components/circle_image.dart';
import 'package:flutter_unit/components/circle_text.dart';
import 'package:flutter_unit/model/widget_model.dart';

class CouponWidgetListItem extends StatelessWidget {
  final WidgetModel data;

  CouponWidgetListItem({this.data});

  final List<int> colors = Cons.tabColors;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(
          shape: CouponShapeBorder(
              hasLine: false, edgeRadius: 25, lineRate: 0.20)),
      child: Container(
        color: Color(colors[data.family.index]).withAlpha(66),
        height: 95,
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Hero(
                tag: "hero_widget_image_${data.name}",
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
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[_buildTitle(), _buildSummary()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color get invColor {
    return Color(colors[data.family.index]);
  }

  Widget _buildTitle() {
    return Expanded(
      child: Row(
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
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              shadows: [Shadow(color: Colors.white, offset: Offset(.5, .5))]),
        ),
      ),
    );
  }
}

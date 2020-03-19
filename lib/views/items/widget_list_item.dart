import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/app/style/shape/coupon_shape_border.dart';
import 'package:flutter_unit/app/style/shape/hole_shape.dart';
import 'package:flutter_unit/components/circle_image.dart';
import 'package:flutter_unit/model/widget_model.dart';

class WidgetListItem extends StatelessWidget {
  final WidgetModel data;

  WidgetListItem({this.data});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(
          shape: CouponShapeBorder(
              hasLine: false, edgeRadius: 25, lineRate: 0.23)),
      child: Container(
        color: Color(0x441194F6),
        height: 100,
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Hero(
                tag: "hero_widget_image_${data.name}",
                child: CircleImage(
                  image: data.image,
                  size: 70,
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

  Widget _buildTitle() => Expanded(
        child: Row(
          children: <Widget>[
            SizedBox(width: 10),
            LimitedBox(
              maxWidth: 130,
              child: Text(data.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                data.nameCN,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            StarScore(
              star: Star(size: 15, fillColor: Colors.blue),
              score: data.lever,
            ),
          ],
        ),
      );

  Widget _buildSummary() => Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
        child: Container(
          constraints: BoxConstraints(maxWidth: 250),
          child: Text(
            //尾部摘要
            data.info,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      );
}

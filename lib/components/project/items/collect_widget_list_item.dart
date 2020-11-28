import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/res/style/shape/techno_shape.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/circle_text.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/model/widget_model.dart';

class CollectWidgetListItem extends StatelessWidget {
  final WidgetModel data;
  final Function(WidgetModel) onDeleteItemClick;

  CollectWidgetListItem({this.data, this.onDeleteItemClick});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Material(
          color: itemColor.withAlpha(66),
          shape: TechnoShapeBorder(color: itemColor),
          child:  Row(
              children: <Widget>[
                _buildLeading(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTitle(),
                      _buildSummary(),
                      StarScore(
                        star: Star(
                            emptyColor: Colors.white,
                            size: 12,
                            fillColor: itemColor),
                        score: data.lever,
                      )
                    ],
                  ),
                ),
              ],
          ),
        ),
        Positioned(
            bottom: 5,
            right: 5,
            child: FeedbackWidget(
              onPressed: () {
                if (onDeleteItemClick != null) {
                  onDeleteItemClick(data);
                }
              },
              child: const Icon(
                CupertinoIcons.delete_solid,
                color: Colors.red,
              ),
            ))
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
                  size: 50,
                  color: itemColor,
                ),
              )
            : CircleImage(
                image: data.image,
                size: 50,
              ),
      );

  Color get itemColor => Color(Cons.tabColors[data.family.index]);

  Widget _buildTitle() => Row(
      children: <Widget>[
        Expanded(
          child: Text(data.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    const Shadow(
                        color: Colors.white, offset: const Offset(.3, .3))
                  ])),
        ),
      ],
    );

  Widget _buildSummary() => Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
      child: Container(
        child: Text(
          data.nameCN,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              shadows: [const Shadow(color: Colors.white, offset: const Offset(.5, .5))]),
        ),
      ),
    );
}

import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:toly_ui/toly_ui.dart';

import '../../../data/exp.dart';

class CollectWidgetListItem extends StatelessWidget {
  final WidgetModel data;
  final Function(WidgetModel model)? onDeleteItemClick;

  const CollectWidgetListItem({Key? key, required this.data, this.onDeleteItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Material(
          color: Theme.of(context).listTileTheme.tileColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6),
            child: Row(
                children: <Widget>[
                  _buildLeading(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildTitle(),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
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
                           const  Spacer(),
                            FeedbackWidget(
                              onPressed: () {
                                onDeleteItemClick?.call(data);
                              },
                              child: const Icon(
                                CupertinoIcons.delete_solid,
                                color: Colors.red,
                                size: 20,
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeading() => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: data.image == null
            ? Material(
                color: Colors.transparent,
                child: CircleText(
                  text: data.name,
                  size: 40,
                  fontSize: 18,
                  color: itemColor,
                ),
              )
            : CircleImage(
                image: data.image!,
                size: 40,
              ),
      );

  Color get itemColor => Cons.tabColors[data.family.index];

  Widget _buildTitle() => Row(
      children: <Widget>[
        Expanded(
          child: Text(data.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        color: Colors.white, offset: Offset(.3, .3))
                  ])),
        ),
      ],
    );

  Widget _buildSummary() => Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: Text(
        data.nameCN,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            shadows: const [Shadow(color: Colors.white, offset: Offset(.5, .5))]),
      ),
    );
}

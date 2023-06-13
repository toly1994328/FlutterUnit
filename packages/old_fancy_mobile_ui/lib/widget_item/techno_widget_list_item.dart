import 'package:app/app.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'package:widget_repository/widget_repository.dart';

class TechnoWidgetListItem extends StatelessWidget {
  final WidgetModel data;

  const TechnoWidgetListItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDark = themeData.brightness == Brightness.dark;
    Color tagColor = isDark?themeData.floatingActionButtonTheme.backgroundColor!: themeData.primaryColor;
    return Stack(
      children: <Widget>[
        Material(
          // color: Colors.transparent,
          color: isDark ? itemColor.withAlpha(22) : itemColor.withAlpha(66),
          shape: TechnoShapeBorder(color: itemColor),
          child: Container(
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
                    children: <Widget>[_buildTitle(), _buildSummary(isDark)],
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildCollectTag(tagColor)
      ],
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
            child:  SizedOverflowBox(
              alignment: Alignment.bottomCenter,
              size: const Size(0, 30 - 8.0),
              child:  Tag(
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
                  // backgroundColor: Colors.bla,
                  text: data.name,
                  size: 60,
                  color: itemColor,
                ),
              )
            : CircleImage(
                image: data.image!,
                size: 55,
              ),
      );

  Color get itemColor => data.death?Colors.grey:Cons.tabColors[data.family.index];


  Widget _buildTitle() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: Text(data.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  decoration: data.deprecated?TextDecoration.lineThrough:TextDecoration.none,
                  decorationThickness: 2,
                  shadows: const [
                    Shadow(color: Colors.white, offset: Offset(.3, .3))
                  ])),
        ),
      ],
    );
  }

  Widget _buildSummary(bool isDark) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        //尾部摘要
        data.info,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: isDark ? Colors.white : Colors.grey[600],
            fontSize: 14,
            shadows: [
              Shadow(
                  color: isDark ? Colors.grey[600]! : Colors.white,
                  offset: Offset(.5, .5))
            ]),
      ),
    );
  }
}

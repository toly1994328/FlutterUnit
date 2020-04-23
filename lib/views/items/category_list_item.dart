import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/components/permanent/circle_text.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/model/category_model.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 

class CategoryListItem extends StatelessWidget {
  final CategoryModel data;
  final Function(CategoryModel) onDeleteItemClick;
  final Function(CategoryModel) onEditItemClick;

  CategoryListItem({this.data, this.onDeleteItemClick,this.onEditItemClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: data.color.withAlpha(88),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 2,
      child: Container(
        child: _buildChild(context),
        padding: EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );

  }

  _buildChild(BuildContext context) {
    var themeColor = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        _buildTitle(themeColor),
        Divider(),
        Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(data.info,
                      style: TextStyle(
                          color: Colors.grey,
                          shadows: [
                            Shadow(color: themeColor, offset: Offset(.2,.2),blurRadius: .5)
                          ])),
                ),
                  Positioned(
                      bottom: 5,
                      right: 5,
                      child:
                      FeedbackWidget(
                        onPressed: () {
                          if (onEditItemClick != null) {
                            onEditItemClick(data);
                          }
                        },
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: themeColor,
                        ),
                      )
                  )
              ],
            )),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            '创建于 ${data.createDate}',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Row _buildTitle(Color themeColor) {
    return Row(
      children: <Widget>[
        CircleText(
          text: "${data.count}",
          size: 35,
          fontSize: 14,
          backgroundColor: data.color,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
              data.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
          FeedbackWidget(
            onPressed: () {
              if (onDeleteItemClick != null) {
                onDeleteItemClick(data);
              }
            },
            child: Icon(
              CupertinoIcons.delete_solid,
              color: Colors.red,
            ),
          )
      ],
    );
  }

//  Widget _buildLeading() => Padding(
//        padding: const EdgeInsets.only(left: 5, right: 5),
//        child: data.image == null
//            ? Material(
//                color: Colors.transparent,
//                child: CircleText(
//                  text: data.name,
//                  size: 50,
//                  color: itemColor,
//                ),
//              )
//            : CircleImage(
//                image: data.image,
//                size: 50,
//              ),
//      );
//
//  Color get itemColor => Color(Cons.tabColors[data.family.index]);
//
//  Widget _buildTitle() {
//    return Row(
//      children: <Widget>[
////        SizedBox(width: 10),
//        Expanded(
//          child: Text(data.name,
//              overflow: TextOverflow.ellipsis,
//              style: TextStyle(
//                  fontSize: 17,
//                  fontWeight: FontWeight.bold,
//                  shadows: [
//                    Shadow(color: Colors.white, offset: Offset(.3, .3))
//                  ])),
//        ),
//      ],
//    );
//  }
//
//  Widget _buildSummary() {
//    return Padding(
//      padding: const EdgeInsets.only(left: 5, bottom: 10, top: 5),
//      child: Container(
//        child: Text(
//          data.nameCN,
//          maxLines: 2,
//          overflow: TextOverflow.ellipsis,
//          style: TextStyle(
//              color: Colors.grey[600],
//              fontSize: 14,
//              shadows: [Shadow(color: Colors.white, offset: Offset(.5, .5))]),
//        ),
//      ),
//    );
//  }
}
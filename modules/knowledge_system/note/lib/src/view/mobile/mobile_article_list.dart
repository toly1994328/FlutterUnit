import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:note/src/repository/model/model.dart';
import 'package:tolyui/tolyui.dart';
class MobileArticleList extends StatelessWidget {
  final List<ArticlePo> articles;
  final ValueChanged<ArticlePo> onTap;
  final int activeId;
  final OnUpdateTitle onUpdateTitle;

  const MobileArticleList(
      {super.key,
      required this.articles,
      required this.activeId,
      required this.onTap,
      required this.onUpdateTitle});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8),
      separatorBuilder: (_, __) => SizedBox(
        height: 6,
      ),
      itemCount: articles.length,
      itemBuilder: (_, index) => MobileArticleItem(
        onTap: onTap,
        active: articles[index].id == activeId,
        article: articles[index],
        onUpdateTitle: onUpdateTitle,
      ),
    );
  }
}

typedef OnUpdateTitle = Function(int id, String title);

class MobileArticleItem extends StatefulWidget {
  final bool active;
  final ArticlePo article;
  final ValueChanged<ArticlePo> onTap;
  final OnUpdateTitle onUpdateTitle;

  const MobileArticleItem({
    super.key,
    required this.active,
    required this.article,
    required this.onTap,
    required this.onUpdateTitle,
  });

  @override
  State<MobileArticleItem> createState() => _MobileArticleItemState();
}

class _MobileArticleItemState extends State<MobileArticleItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.article),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 6,
              children: [
                Icon(
                  widget.article.type == 1 ? Icons.event_note : Icons.wordpress,
                  size: 20,
                  color: Color(0xffa6aebd),
                ),
                Expanded(
                  child: Text(
                    widget.article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  style: TextStyle(fontSize: 12),
                  widget.article.createDate,
                ),
                Text(" → "),
                Text(
                  style: TextStyle(fontSize: 12),
                  widget.article.updateDate,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _updateTitle() {
    String value = _ctrl?.text ?? '';
    if (value.isEmpty) return;
    widget.onUpdateTitle(widget.article.id, _ctrl?.text ?? '');
  }

  TextEditingController? _ctrl;
  FocusNode? _focusNode;
}

//          Container(
//                   alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   margin: EdgeInsets.symmetric(horizontal: 6),
//                   height: 32,
//                   width: 200,
//                   decoration: BoxDecoration(
//                     color: Color(0xffd7e2ff),
//                     borderRadius: BorderRadius.circular(4)
//                   ),
//                   child: Text('第一篇',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff5b89fe)),),
//                 ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   margin: EdgeInsets.symmetric(horizontal: 6),
//                   height: 32,
//                   width: 200,
//                   decoration: BoxDecoration(
//                     // color: Color(0xffd7e2ff),
//                     borderRadius: BorderRadius.circular(4)
//                   ),
//                   child: Text('第二篇',style: TextStyle(color: Colors.black),),
//                 ),

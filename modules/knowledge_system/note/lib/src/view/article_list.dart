import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:note/src/repository/model/model.dart';
import 'package:tolyui/tolyui.dart';

class ArticleList extends StatelessWidget {
  final List<ArticlePo> articles;
  final ValueChanged<ArticlePo> onTap;
  final int activeId;
  final OnUpdateTitle onUpdateTitle;

  const ArticleList(
      {super.key,
      required this.articles,
      required this.activeId,
      required this.onTap, required this.onUpdateTitle});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (_, index) => ArticleItem(
        onTap: onTap,
        active: articles[index].id == activeId,
        article: articles[index], onUpdateTitle: onUpdateTitle,
      ),
    );
  }
}

typedef OnUpdateTitle = Function(int id, String title);

class ArticleItem extends StatefulWidget {
  final bool active;
  final ArticlePo article;
  final ValueChanged<ArticlePo> onTap;
  final OnUpdateTitle onUpdateTitle;

  const ArticleItem({
    super.key,
    required this.active,
    required this.article,
    required this.onTap,
    required this.onUpdateTitle,
  });

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: () => widget.onTap(widget.article),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.symmetric(horizontal: 6),
          width: 240,
          decoration: BoxDecoration(
              color: widget.active
                  ? Color(0xffd7e2ff)
                  : _hovered
                      ? Color(0xffe1e6ed)
                      : null,
              borderRadius: BorderRadius.circular(4)),
          height: 32,
          child: Row(
            spacing: 6,
            children: [
              Icon(
                widget.article.type == 1 ? Icons.event_note : Icons.wordpress,
                size: 20,
                color: widget.active ? Color(0xff5b89fe) : Color(0xffa6aebd),
              ),
              Expanded(
                child: _editMode
                    ? TextField(
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                            isCollapsed: true, border: InputBorder.none),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: widget.active ? FontWeight.bold : null,
                            color: widget.active ? Color(0xff5b89fe) : null),
                        onTapOutside: (_) {
                          _updateTitle();
                          setState(() {
                            _editMode = false;
                          });
                        },
                        onSubmitted: (v) {
                          _updateTitle();
                          setState(() {
                            _editMode = false;
                          });
                        },
                        controller: _ctrl,
                      )
                    : Text(
                        widget.article.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: widget.active ? FontWeight.bold : null,
                            color: widget.active ? Color(0xff5b89fe) : null),
                      ),
              ),
              if (_hovered)
                TolyAction(
                    child: Icon(
                     _editMode?Icons.check: Icons.edit,
                      size: 16,
                      color: Color(0xff4e5a70),
                    ),
                    onTap: () {
                      if(_editMode){
                        _updateTitle();
                        setState(() {
                          _editMode = false;
                        });
                        return;
                      }

                      widget.onTap(widget.article);
                      _ctrl = TextEditingController(text: widget.article.title);
                      _focusNode = FocusNode();
                      Future.delayed(Duration(milliseconds: 20)).then((_) {
                        _focusNode!.requestFocus();
                        _ctrl!.value = _ctrl!.value.copyWith(
                            selection: TextSelection(
                                baseOffset: 0,
                                extentOffset: _ctrl!.text.length));
                      });
                      setState(() {
                        _editMode = true;
                      });
                    }),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTitle(){
    String value = _ctrl?.text??'';
    if(value.isEmpty) return;
    widget.onUpdateTitle(widget.article.id,_ctrl?.text??'');
  }

  bool _hovered = false;
  bool _editMode = false;
  TextEditingController? _ctrl;
  FocusNode? _focusNode;
  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _hovered = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _hovered = false;
    });
  }
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

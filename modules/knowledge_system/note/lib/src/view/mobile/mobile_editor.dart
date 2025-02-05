import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:note/note.dart';

import '../../repository/article_repository.dart';
import '../../repository/model/model.dart';

class MobileEditor extends StatefulWidget {
  final ArticlePo article;

  const MobileEditor({super.key, required this.article});

  @override
  State<MobileEditor> createState() => _MobileEditorState();
}

class _MobileEditorState extends State<MobileEditor> {
  TextEditingController ctrl = TextEditingController();
  ArticleRepository _repository = HttpArticleRepository();
  FocusNode titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _loadArticleContent(widget.article.id);
    titleFocusNode.addListener(_titleFocusNode);
  }

  // void _loadArticleContent(int id) async {
  //   ApiRet<String> ret = await _repository.open(id);
  //   if (ret.success) {
  //     ctrl.text = ret.data;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ArtSysBloc bloc = context.watch<ArtSysBloc>();

    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Color(0xfffafafa),
        // title: Text(widget.article.title),
        actions: [IconButton(onPressed: () {
          showBottomTip(context);
        }, icon: Icon(Icons.more_vert))],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(32),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0, left: 18),
              child: Row(
                spacing: 8,
                children: [
                  Text(
                    '${bloc.state.active?.updateDate}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          0xffadadad,
                        )),
                  ),
                  SizedBox(height: 14, child: VerticalDivider()),
                  Text(
                    '${bloc.ctrl.text.length} 字',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          0xffadadad,
                        )),
                  ),
                  SizedBox(height: 14, child: VerticalDivider()),
                  Text(
                    '全部文件',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          0xffadadad,
                        )),
                  ),
                ],
              ),
            )),
      ),
      body: Column(
        children: [
          Divider(),
          TextField(
            controller: bloc.titleCtrl,
            focusNode: titleFocusNode,
            maxLines: 4,
            minLines: 1,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8)),
          ),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 14),
              onChanged: (String value) async {
                if (widget.article.id != null) {
                  ApiRet<bool> ret =
                      await _repository.write(widget.article.id, value);
                }
              },
              maxLines: null,
              minLines: null,
              controller: bloc.ctrl,
              expands: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
            ),
          ),
        ],
      ),
    );
  }

  void _titleFocusNode() {
    print("=====_titleFocusNode============");
    if(!titleFocusNode.hasFocus){
      ArtSysBloc bloc = context.read<ArtSysBloc>();
      bloc.updateTitleV2();
    }
  }

  void showBottomTip(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => PopBottomTip(
        onDelete: () async{
          await context.read<ArtSysBloc>().delete();
          Navigator.of(context).pop();
        },
        message: '当前文当更多操作',
        deleteText: '删除文档',
      ),
    );
  }
}


class PopBottomTip extends StatelessWidget {
  final VoidCallback onDelete;
  final String message;
  final String deleteText;

  const PopBottomTip({
    super.key,
    required this.onDelete,
    required this.message,
    required this.deleteText,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Material(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            )),
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Colors.grey.withOpacity(0.2)))),
                  child: Text(
                    message,
                    style: TextStyle(color: Color(0xff8f8f8f)),
                  )),

              InkWell(
                splashColor: Colors.white,
                onTap: () {
                  Navigator.of(context).pop();
                  onDelete();
                },
                child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: Text(
                      deleteText,
                      style: TextStyle(color: Color(0xfff14835), fontSize: 16),
                    )),
              ),
              Container(
                color: Color(0xfff2f3f5),
                height: 8,
              ),
              InkWell(
                splashColor: Colors.white,
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: Text(
                      '取消',
                      style: TextStyle(fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

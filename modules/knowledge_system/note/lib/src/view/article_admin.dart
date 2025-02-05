import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/note.dart';
import 'package:tolyui/tolyui.dart';
import 'package:app/app.dart';
import 'article_editor.dart';
import 'article_list.dart';

class ArticleAdmin extends StatefulWidget {
  const ArticleAdmin({super.key});

  @override
  State<ArticleAdmin> createState() => _ArticleAdminState();
}

class _ArticleAdminState extends State<ArticleAdmin> {

  @override
  Widget build(BuildContext context) {
    ArtSysBloc bloc = context.watch<ArtSysBloc>();
    ListStatus status = bloc.state.status;
    bool hasActive = bloc.state.active != null;

    Widget table = switch (status) {
      LoadingStatus() => const CupertinoActivityIndicator(),
      SuccessStatus() => ArticleList(
          articles: bloc.state.articles,
          activeId: bloc.state.active?.id ?? -1,
          onTap: bloc.select,
          onUpdateTitle: bloc.updateTitle,
        ),
      FailedStatus() => Text("Error:${status.error}"),
    };
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 240,
            decoration: BoxDecoration(color: Color(0xfffafbfc)
                // gradient: LinearGradient(colors: [
                //   Color(0xffe9f1f8),
                //   Color(0xffebf2f8),
                // ])
                ),
            child: Column(
              children: [
                DragToMoveWrapper(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 46,
                    child: Row(
                      spacing: 6,
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          '匠心巧记',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff242a39)),
                        ),
                        Spacer(),
                        TolyAction(
                          child: Icon(
                            Icons.sync,
                            size: 20,
                            color: Color(0xff242a39),
                          ),
                          onTap: () async{
                            bloc.loadFirstFrame();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: ElevatedButton(
                          onPressed: bloc.newArticle,
                          child: Wrap(
                            spacing: 6,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                "新建",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          style: FillButtonPalette(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            foregroundPalette: Palette.all(Colors.white),
                            borderRadius: BorderRadius.circular(6),
                            backgroundPalette: const Palette(
                              normal: Color(0xff1890ff),
                              hover: Color(0xff40a9ff),
                              pressed: Color(0xff096dd9),
                            ),
                          ).style,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(child: table)
              ],
            ),
          ),
          VerticalDivider(),
          Expanded(
              child: Column(
            children: [
              Container(
                height: 46,
                child: Row(
                  children: [
                    if (hasActive)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextField(
                            onTapOutside: (_) => bloc.updateTitleV2(),
                            onSubmitted: (_) => bloc.updateTitleV2(),
                            controller: bloc.titleCtrl,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (!hasActive) Spacer(),
                    WindowButtons()
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  onChanged: bloc.write,
                  maxLines: null,
                  minLines: null,
                  controller: bloc.ctrl,
                  expands: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                ),
              ),
            ],
          ))
          // Expanded(
          //   child: Column(
          //     children: [
          //       Container(
          //         height: 52,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //           child: Row(
          //             children: [
          //               Spacer(),
          //               Button(onPressed: () => showAddDialog(context)),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Expanded(child: table),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: TolyPagination(
          //           pageSize: 20,
          //           total: (total*1.0),
          //           initIndex: currentIndex,
          //           onPageChanged: _onPageChanged,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  // void _onPageChanged(int value) {
  //   queryArticle(value);
  // }

  // Future<void> queryArticle(int page) async {
  //   setState(() {
  //     status = const TaskLoading();
  //   });
  //   ApiRet<PaginateList<ArticlePo>> ret =
  //       await _repository.list(SizeFilter(page: page));
  //   if (ret.success) {
  //     articles = ret.data.list;
  //     total = ret.data.total;
  //     setState(() {
  //       status = const TaskSuccess();
  //     });
  //   } else {
  //     status = TaskFailed(ret.trace);
  //     setState(() {});
  //   }
  // }

  void showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EditArticleDialog(
          onCreate: (payload) async {
            // 在这里处理更新后的文章
            // ApiRet<bool> ret = await _repository.create(payload);
            // if (ret.success) {
            //   currentIndex = 1;
            //   queryArticle(currentIndex);
            // }
          },
        );
      },
    );
  }

}

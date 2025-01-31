import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:tolyui/tolyui.dart';
import 'package:app/app.dart';
import '../repository/article_repository.dart';
import '../repository/model/model.dart';
import 'article_editor.dart';
import 'article_item.dart';
import 'components/button/button.dart';
import 'article_list.dart';

class ArticleAdmin extends StatefulWidget {
  const ArticleAdmin({super.key});

  @override
  State<ArticleAdmin> createState() => _ArticleAdminState();
}

class _ArticleAdminState extends State<ArticleAdmin> {
  ArticleRepository _repository = HttpArticleRepository();

  @override
  void initState() {
    super.initState();
    _queryScienceArticle();
  }

  List<ArticlePo> articles = [];
  int total = 0;
  int currentIndex = 1;
  ArticlePo? active;
  TaskStatus status = const TaskNone();

  TextEditingController ctrl = TextEditingController();
  TextEditingController titleCtrl = TextEditingController();

  Future<void> _queryScienceArticle() async {
    setState(() {
      status = const TaskLoading();
    });
    ApiRet<PaginateList<ArticlePo>> ret = await _repository.list(SizeFilter());
    if (ret.success) {
      articles = ret.data.list;
      total = ret.data.total;
      setState(() {
        status = TaskSuccess();
      });
    } else {
      status = TaskFailed(ret.trace);
      setState(() {});
    }
  }

  void updateTitle(int id, String title) async {
    ApiRet<ArticlePo> ret =
        await _repository.update(id, ArticleUpdatePayload(title: title));
    if (ret.success) {
      _loadArticleContent(id);
      _queryScienceArticle();
      titleCtrl.text = ret.data.title;
      setState(() {
        active = ret.data;
      });
    } else {
      print(ret.trace?.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget table = switch (status) {
      TaskNone() => Scaffold(),
      TaskLoading() => const CupertinoActivityIndicator(),
      TaskSuccess() => ArticleList(
          articles: articles,
          activeId: active?.id ?? -1,
          onTap: (ArticlePo article) {
            if (article.type == 1) {
              _loadArticleContent(article.id);
            } else {}
            titleCtrl.text = article.title;

            setState(() {
              active = article;
            });
          },
          onUpdateTitle: updateTitle,
        ),
      TaskFailed() => Scaffold(),
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
                          onTap: () {},
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
                          onPressed: () async {
                            await _repository.create(
                              ArticleCreatePayload(
                                subtitle: '',
                                title: '新建文档',
                                url: '',
                                cover: '',
                                type: 1,
                                createAt: DateTime.now().toIso8601String(),
                              ),
                            );
                            _queryScienceArticle();
                          },
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
                    if (active != null)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextField(
                            onTapOutside: (_){
                              updateTitle(active?.id ?? 0, titleCtrl.text);
                            },
                            onSubmitted: (String value) {
                              updateTitle(active?.id ?? 0, value);
                            },
                            controller: titleCtrl,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (active == null) Spacer(),
                    WindowButtons()
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  onChanged: (String value) async {
                    if (active?.id != null) {
                      ApiRet<bool> ret =
                          await _repository.write(active!.id, value);
                      print(ret.msg);
                    }
                  },
                  maxLines: null,
                  minLines: null,
                  controller: ctrl,
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

  void _onPageChanged(int value) {
    queryArticle(value);
  }

  Future<void> queryArticle(int page) async {
    setState(() {
      status = const TaskLoading();
    });
    ApiRet<PaginateList<ArticlePo>> ret =
        await _repository.list(SizeFilter(page: page));
    if (ret.success) {
      articles = ret.data.list;
      total = ret.data.total;
      setState(() {
        status = const TaskSuccess();
      });
    } else {
      status = TaskFailed(ret.trace);
      setState(() {});
    }
  }

  void showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EditArticleDialog(
          onCreate: (payload) async {
            // 在这里处理更新后的文章
            ApiRet<bool> ret = await _repository.create(payload);
            if (ret.success) {
              currentIndex = 1;
              queryArticle(currentIndex);
            }
          },
        );
      },
    );
  }

  void _loadArticleContent(int id) async {
    ApiRet<String> ret = await _repository.open(id);
    if (ret.success) {
      ctrl.text = ret.data;
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_dio/fx_dio.dart';

import '../../repository/article_repository.dart';
import '../../repository/model/model.dart';
import '../article_list.dart';
import 'mobile_article_list.dart';
import 'mobile_editor.dart';
import 'note.dart';

class MobileArticlePage extends StatefulWidget {
  const MobileArticlePage({super.key});

  @override
  State<MobileArticlePage> createState() => _MobileArticlePageState();
}

class _MobileArticlePageState extends State<MobileArticlePage> {
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
    ApiRet<List<ArticlePo>> ret = await _repository.list(SizeFilter());
    if (ret.success) {
      articles = ret.data;
      total = ret.paginate?.total ?? 0;
      setState(() {
        status = TaskSuccess();
      });
    } else {
      status = TaskFailed(ret.trace);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PinnedHeaderSliverNode2();
    Widget body = switch (status) {
      TaskNone() => SizedBox(),
      TaskLoading() => const CupertinoActivityIndicator(),
      TaskSuccess() => MobileArticleList(
          articles: articles,
          activeId: active?.id ?? -1,
          onTap: (ArticlePo article) {
            if (article.type == 1) {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return MobileEditor(
                  article: article,
                );
              }));
              // _loadArticleContent(article.id);
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
      backgroundColor: Color(0xfff5f5f5),
      bottomNavigationBar: Container(
        height: 56,
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(),
        mini: true,
        elevation: 4,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('匠心巧记'),
      ),
      body: body,
    );
  }

  updateTitle(int id, String title) {}
}

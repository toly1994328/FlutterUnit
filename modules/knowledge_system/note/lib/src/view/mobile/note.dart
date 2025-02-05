// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/note.dart';

import '../../repository/model/model.dart';
import 'mobile_article_list.dart';
import 'mobile_editor.dart';

class PinnedHeaderSliverNode2 extends StatefulWidget {
  const PinnedHeaderSliverNode2({super.key});

  @override
  State<PinnedHeaderSliverNode2> createState() =>
      _PinnedHeaderSliverNode2State();
}

class _PinnedHeaderSliverNode2State extends State<PinnedHeaderSliverNode2> {
  int count = 0;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    ArtSysBloc bloc = context.watch<ArtSysBloc>();
    ListStatus status = bloc.state.status;
    List<ArticlePo> articles = bloc.state.articles;
    bool hasActive = bloc.state.active != null;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 52,
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(),
        mini: true,
        elevation: 4,

        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: () async{
          ArtSysBloc bloc =  context.read<ArtSysBloc>();
          await bloc.newArticle();
          ArticlePo article = bloc.state.articles.first;
          bloc.select(article);
          await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return BlocProvider.value(
              value: bloc,
              child: MobileEditor(
                article: article,
              ),
            );
          }));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xfff5f5f5),
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          _buildSliverBar(),
          _buildTitleText(),
          const PinnedHeaderSliver(child: Divider()),
          ...ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8),
            separatorBuilder: (_, __) => SizedBox(
              height: 6,
            ),
            itemCount: articles.length,
            itemBuilder: (_, index) => MobileArticleItem(
              onTap: _onTap,
              active: false,
              article: articles[index],
              onUpdateTitle: onUpdateTitle,
            ),
          ).buildSlivers(context),
        ],
      ),
    );
  }

  Widget _buildSliverBar() {
    const Icon icon = Icon(Icons.more_vert);
    const TextStyle style =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const Text text = Text('匠心巧记', style: style);
    Widget action = IconButton(onPressed: () {}, icon: icon);
    return SliverLayoutBuilder(builder: (_, scs) {
      double factor = (scs.scrollOffset / kToolbarHeight).clamp(0, 1);
      factor = factor < 0.2 ? 0 : factor;
      AppBar header = AppBar(
        backgroundColor: Color(0xfff5f5f5),
        surfaceTintColor: Colors.transparent,
        actions: [action],
        centerTitle: true,
        title: Opacity(opacity: factor, child: text),
      );
      return PinnedHeaderSliver(child: header);
    });
  }

  Widget _buildTitleText() {
    const TextStyle style =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    const Text text = Text('匠心巧记', style: style);
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, bottom: 8),
        child: text,
      ),
    );
  }

  void _onTap(ArticlePo article) async {
    if (article.type == 1) {
      ArtSysBloc bloc = context.read<ArtSysBloc>();
      bloc.select(article);
      await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return BlocProvider.value(
          value: context.read<ArtSysBloc>(),
          child: MobileEditor(
            article: article,
          ),
        );
      }));
      // _loadArticleContent(article.id);
    } else {}
  }

  onUpdateTitle(int id, String title) {}
}

class _ItemList extends StatelessWidget {
  const _ItemList({
    super.key,
    this.itemCount = 50,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListTile(
            dense: true,
            textColor: colorScheme.secondary,
            title: Text('#$index title'),
            subtitle: Text('Subtitle in line $index'),
          );
        },
        childCount: itemCount,
      ),
    );
  }
}

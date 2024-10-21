// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinnedHeaderSliverNode3 extends StatefulWidget {
  const PinnedHeaderSliverNode3({super.key});

  @override
  State<PinnedHeaderSliverNode3> createState() => _PinnedHeaderSliverNode3State();
}

class _PinnedHeaderSliverNode3State extends State<PinnedHeaderSliverNode3> {
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          _buildSliverBar(),
          _buildTitleText(),
          _buildSliverSearch(),

//           PinnedHeaderSliver(child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: TextField(
// decoration: InputDecoration(
//   filled: true,
//   fillColor: Colors.white,
//   border: InputBorder.none
// ),
//             ),
//           )),

          const _ItemList(),
        ],
      ),
    );
  }

  Widget _buildSliverBar() {
    const Icon icon = Icon(CupertinoIcons.settings, color: Colors.blue);
    const TextStyle style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const Text text = Text('Settings', style: style);
    Widget action = IconButton(onPressed: () {}, icon: icon);
    return SliverLayoutBuilder(builder: (_, scs) {
      double factor = (scs.scrollOffset / kToolbarHeight).clamp(0, 1);
      factor = factor < 0.2 ? 0 : factor;
      AppBar header = AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        actions: [action],
        centerTitle: true,
        title: Opacity(opacity: factor, child: text),
      );
      return PinnedHeaderSliver(child: header);
    });
  }

  Widget _buildTitleText() {
    const TextStyle style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    const Text text = Text('Settings', style: style);
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, bottom: 8),
        child: text,
      ),
    );
  }

  Widget _buildSliverSearch() {
    BoxDecoration decoration = BoxDecoration(
        color: const Color(0xffefeff1), borderRadius: BorderRadius.circular(6));
    Widget prefix = const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Icon(CupertinoIcons.search, size: 20, color: Color(0xff808082))
    );
    return PinnedHeaderSliver(
        child: ColoredBox(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 12, left: 12),
                child: CupertinoTextField(
                  readOnly: true,
                  placeholder: '搜索',
                  onTap: _toSearchPage,
                  decoration: decoration,
                  prefix:prefix,
                  style: const TextStyle(fontSize: 14),
                  placeholderStyle: const TextStyle(color: Color(0xff808082)),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
              ),
              const Divider(),
            ],
          ),
        ));
  }

  void _toSearchPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(title: const Text('SearchPage')))),
    );
  }
}

// A placeholder SliverList of 25 items.
class _ItemList extends StatelessWidget {
  const _ItemList({
    super.key,
    this.itemCount = 50,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme
        .of(context)
        .colorScheme;
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

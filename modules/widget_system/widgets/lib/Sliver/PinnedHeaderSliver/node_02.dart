// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinnedHeaderSliverNode2 extends StatefulWidget {
  const PinnedHeaderSliverNode2({super.key});

  @override
  State<PinnedHeaderSliverNode2> createState() => _PinnedHeaderSliverNode2State();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          _buildSliverBar(),
          _buildTitleText(),
          const PinnedHeaderSliver(child: Divider()),
          const _ItemList(),
        ],
      ),
    );
  }

  Widget _buildSliverBar() {
    const Icon icon = Icon(CupertinoIcons.settings, color: Colors.blue);
    const TextStyle style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const Text text = Text('Settings', style: style);
    Widget action = IconButton(onPressed: () {}, icon: icon );
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

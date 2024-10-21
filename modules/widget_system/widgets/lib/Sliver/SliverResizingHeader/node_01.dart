// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';


class SliverResizingHeaderDemo1 extends StatefulWidget {
  const SliverResizingHeaderDemo1({ super.key });

  @override
  State<SliverResizingHeaderDemo1> createState() => _SliverResizingHeaderDemo1State();
}

class _SliverResizingHeaderDemo1State extends State<SliverResizingHeaderDemo1> {
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Scrollbar(
            controller: scrollController,
            child: CustomScrollView(
              controller: scrollController,
              slivers: const <Widget>[
                SliverResizingHeader(
                  minExtentPrototype: ListHeader(text: 'One'),
                  maxExtentPrototype: ListHeader(text: 'One\nTwo\nThree\n2'),
                  child: ListHeader(
                    text: 'SliverResizingHeader\nWith Two Optional\nLines of Text\n7777',
                  ),
                ),
                ItemList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// A widget that displays its text within a thick rounded rectangle border
class ListHeader extends StatelessWidget {
  const ListHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      color: colorScheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            width: 7,
            color: colorScheme.outline,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium!.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}

// A placeholder SliverList of 50 items.
class ItemList extends StatelessWidget {
  const ItemList({
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
          return Card(
            color: colorScheme.onSecondary,
            child: ListTile(
              textColor: colorScheme.secondary,
              title: Text('Item $index'),
            ),
          );
        },
        childCount: itemCount,
      ),
    );
  }
}


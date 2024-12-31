// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Flutter code sample for [Focus].

void main() => runApp(const FocusExampleApp());

class FocusExampleApp extends StatelessWidget {
  const FocusExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FocusDemo2(),
    );
  }
}

class _FocusTiled extends StatelessWidget {
  const _FocusTiled(
    this.data, {
    super.key,
    required this.autofocus,
  });

  final String data;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: autofocus,
      child: Builder(builder: _buildTiled),
    );
  }

  Widget _buildTiled(BuildContext context) {
    FocusNode node = Focus.of(context);
    bool focus = node.hasFocus;
    Color color = focus ? Colors.blue : Colors.white;
    Color? textColor = focus ? Colors.white : null;
    return GestureDetector(
      onTap: node.requestFocus,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        color: color,
        child: Text(data, style: TextStyle(color: textColor)),
      ),
    );
  }
}

class FocusDemo2 extends StatelessWidget {
  const FocusDemo2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 56,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) => _FocusTiled(
          'Item $index',
          autofocus: index == 0,
        ),
        itemCount: 50,
      ),
    );
  }
}

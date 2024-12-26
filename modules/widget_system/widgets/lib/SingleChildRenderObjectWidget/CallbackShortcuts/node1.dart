// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CallbackShortcutsDemo1 extends StatefulWidget {
  const CallbackShortcutsDemo1({super.key});

  @override
  State<CallbackShortcutsDemo1> createState() => _CallbackShortcutsDemo1State();
}

class _CallbackShortcutsDemo1State extends State<CallbackShortcutsDemo1> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(_onFocusChange);
    _initActionBindings();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();

    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TapRegion(
        onTapInside: (_) => focusNode.requestFocus(),
        onTapOutside: (_) => focusNode.unfocus(),
        child: CallbackShortcuts(
          bindings: _actionBindings,
          child: Focus(autofocus: true, focusNode: focusNode, child: _display()),
        ),
      ),
    );
  }

  Map<ShortcutActivator, VoidCallback> _actionBindings = {};

  void _initActionBindings() {
    _actionBindings = {
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.arrowUp): increase,
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.arrowDown): decrease,
      const SingleActivator(LogicalKeyboardKey.keyR, control: true): reset,
    };
  }

  void increase() {
    setState(() => count = count + 1);
  }

  void decrease() {
    setState(() => count = count - 1);
  }

  void reset() {
    setState(() => count = 0);
  }

  Widget _display() {
    Color color = focusNode.hasFocus ? Colors.blue : Colors.grey;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: color)),
      width: 460,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      height: 60,
      child: focusNode.hasFocus
          ? _CounterDisplay(counter: count)
          : Text(
        focusNode.hasFocus ? '键盘输入点东西吧' : '点击我获取焦点',
        style: TextStyle(color: color),
      ),
    );
  }
}

class _CounterDisplay extends StatelessWidget {
  final int counter;

  const _CounterDisplay({
    super.key,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 12, color: Colors.grey);

    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'count: $counter',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
        Wrap(
          spacing: 6,
          children: <Widget>[
            Text('【Ctrl+↑】:数字+1', style: style),
            Text('【Ctrl+↓】:数字-1', style: style),
            Text('【Ctrl+R】:归 0', style: style),
          ],
        ),
      ],
    );
  }
}

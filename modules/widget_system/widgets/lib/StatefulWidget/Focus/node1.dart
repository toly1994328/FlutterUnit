// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FocusDemo1 extends StatefulWidget {
  const FocusDemo1({super.key});

  @override
  State<FocusDemo1> createState() => _FocusDemo1State();
}

class _FocusDemo1State extends State<FocusDemo1> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onFocusChange: _onFocusChange,
      child: GestureDetector(
        onTap: _toggleFocus,
        child: _FocusBox(active: _focusNode.hasFocus),
      ),
    );
  }

  void _onFocusChange(bool value) {
    setState(() {});
  }

  void _toggleFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }
}

class _FocusBox extends StatelessWidget {
  final bool active;

  const _FocusBox({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    Color color = active ? Colors.blue : Colors.white;
    Color borderColor = active ? Colors.lightBlue : Colors.grey;
    Color? textColor = active ? Colors.white : null;
    String text = active ? "点击失去焦点" : '点击获取焦点';
    return Container(
      width: 120,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
        color: color,
      ),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(color: textColor)),
    );
  }
}

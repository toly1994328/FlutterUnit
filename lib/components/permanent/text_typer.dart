import 'dart:async';

import 'package:flutter/material.dart';

class TextTyper extends StatefulWidget {
  final String text;
  final Duration duration;
  final TextStyle textStyle;

  const TextTyper(
      {required this.text,
      Key? key,
      this.textStyle =
          const TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
      this.duration = const Duration(milliseconds: 150)})
      : super(key: key);

  @override
  _TextTyperState createState() => _TextTyperState();
}

class _TextTyperState extends State<TextTyper> {
  final ValueNotifier<String> data = ValueNotifier<String>("");
   Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, _type);
  }

  int currentIndex = 0;

  String get currentText => widget.text.substring(0, currentIndex);

  void _type(Timer timer) {
    if (currentIndex < widget.text.length) {
      currentIndex++;
      data.value = currentText;
    } else {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  AnimatedBuilder(
        animation: data,
        builder: _buildByAnim,
    );
  }

  Widget _buildByAnim(BuildContext context, Widget? child) => Text(
        data.value,
        style: widget.textStyle,
      );
}

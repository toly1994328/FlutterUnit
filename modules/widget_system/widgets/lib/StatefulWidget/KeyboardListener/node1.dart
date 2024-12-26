import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardListenerDemo1 extends StatefulWidget {
  const KeyboardListenerDemo1({super.key});

  @override
  State<KeyboardListenerDemo1> createState() => _KeyboardListenerDemo1State();
}

class _KeyboardListenerDemo1State extends State<KeyboardListenerDemo1> {
  FocusNode focusNode = FocusNode();
  List<KeyEvent> events = [];
  ScrollController _ctrl = ScrollController();

  @override
  void initState() {
    focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TapRegion(
        onTapInside: (_) {
          focusNode.requestFocus();
        },
        onTapOutside: (_) {
          focusNode.unfocus();
        },
        child: KeyboardListener(
          autofocus: true,
          focusNode: focusNode,
          onKeyEvent: _onKeyEvent,
          child: _buildDisplay(),
        ),
      ),
    );
  }

  void _onKeyEvent(KeyEvent value) {
    events.add(value);
    setState(() {});
    _scrollToEnd();
    print('${value.runtimeType}:${value.logicalKey.keyLabel}');
  }

  void _onFocusChange() {
    if (!focusNode.hasFocus) {
      events.clear();
    }
    setState(() {});
  }

  void _scrollToEnd() async {
    if (_ctrl.hasClients) {
      await Future.delayed(Duration(milliseconds: 200));
      _ctrl.animateTo(_ctrl.position.maxScrollExtent,
          duration: Duration(milliseconds: 100), curve: Curves.ease);
    }
  }

  Widget _buildDisplay() {
    Color color = focusNode.hasFocus ? Colors.blue : Colors.grey;

    return Container(
      decoration: BoxDecoration(border: Border.all(color: color)),
      width: 460,
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      height: 60,
      child: events.isNotEmpty
          ? SizedBox(
              width: 460,
              height: 60,
              child: ListView.builder(
                  controller: _ctrl,
                  itemCount: events.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => KeyBoardBox(
                        event: events[index],
                      )),
            )
          : Text(
              focusNode.hasFocus ? '键盘输入点东西吧' : '点击我获取焦点',
              style: TextStyle(color: color),
            ),
    );
  }
}

class KeyBoardBox extends StatelessWidget {
  final KeyEvent event;

  const KeyBoardBox({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    Color? color;
    if (event is KeyDownEvent) {
      color = Colors.blue;
    }
    if (event is KeyRepeatEvent) {
      color = Colors.green;
    }
    if (event is KeyUpEvent) {
      color = Colors.grey;
    }
    return Center(
      child: Container(
        margin: EdgeInsets.only(right: 4),
        width: 32,
        height: 32,
        decoration: BoxDecoration(color: color),
        alignment: Alignment.center,
        child: Text(
          event.logicalKey.keyLabel,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 8, height: 1),
        ),
      ),
    );
  }
}

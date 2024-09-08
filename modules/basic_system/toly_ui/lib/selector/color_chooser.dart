import 'package:flutter/material.dart';

import '../button/feedback_widget.dart';



typedef CheckCallback<T> = void Function(T color);

class ColorChooser extends StatefulWidget {
  const ColorChooser(
      {Key? key,
        this.defaultIndex=0,
      this.radius = 10,
      required this.colors,
      required this.onChecked})
      : super(key: key);
  final double radius;
  final List<Color> colors;
  final Function(Color)? onChecked;
  final int defaultIndex;

  @override
  _ColorChooserState createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  List<bool> _checkLi=[];
  int _perPosition = 0;

  @override
  void initState() {
    _perPosition=widget.defaultIndex;
    _checkLi = List.generate(widget.colors.length, (_) => false);
    _checkLi[_perPosition] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> li = [];
    for (int i = 0; i < widget.colors.length; i++) {
      li.add(FeedbackWidget(
        a: 0.8,
          onPressed: () {
            _checkLi[_perPosition] = false;
            _perPosition = i;
            _checkLi[i] = true;
            widget.onChecked?.call(widget.colors[i]);
            setState(() {});
          },
          child: CircleAvatar(
            backgroundColor: widget.colors[i],
            radius: widget.radius,
            child: _checkLi[i]
                ? const Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.white,
                  )
                : const SizedBox.shrink(),
//              checked: _checkLi[i]
          )));
    }
    return Wrap(spacing: 10, runSpacing: 10, children: li);
  }
}

class IconChooser extends StatefulWidget {
  const IconChooser(
      {Key? key,
      this.radius = 20,
      required this.icons,
      required this.onChecked,
      this.initialIndex = 0})
      : super(key: key);
  final double radius;
  final List<IconData> icons;
  final int initialIndex;
  final CheckCallback<int> onChecked;

  @override
  _IconChooserState createState() => _IconChooserState();
}

class _IconChooserState extends State<IconChooser> {
  List<bool> _checkLi=[];
  int _perPosition = 0;

  @override
  void initState() {
    _checkLi = List.generate(widget.icons.length, (_) => false);
    _checkLi[widget.initialIndex] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> li = <Widget>[];
    for (int i = 0; i < widget.icons.length; i++) {
      li.add(GestureDetector(
          onTap: () {
            _checkLi[_perPosition] = false;
            _perPosition = i;
            _checkLi[i] = true;
            widget.onChecked(i);
            setState(() {});
          },
          child: buildIcon(checked: _checkLi[i], icon: widget.icons[i])));
    }
    return Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 25,
        children: li);
  }

  Widget buildIcon({bool checked = false, IconData? icon}) {
    Color defaultColor = Colors.black26;
    Color activeColor = Colors.blue;
    return Icon(
      icon,
      color: checked ? activeColor : defaultColor,
      size: 35,
    );
  }
}

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class KeepAliveDemo extends StatelessWidget {
  const KeepAliveDemo({super.key});

  List<Color> get data => [
    Colors.purple[50]!,
    Colors.purple[100]!,
    Colors.purple[200]!,
    Colors.purple[300]!,
    Colors.purple[400]!,
    Colors.purple[500]!,
    Colors.purple[600]!,
    Colors.purple[700]!,
    Colors.purple[800]!,
    Colors.purple[900]!,
    Colors.red[50]!,
    Colors.red[100]!,
    Colors.red[200]!,
    Colors.red[300]!,
    Colors.red[400]!,
    Colors.red[500]!,
    Colors.red[600]!,
    Colors.red[700]!,
    Colors.red[800]!,
    Colors.red[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index) => ColorBox(
          color: data[index],
          index: index,
        ),
      ),
    );
  }
}

class ColorBox extends StatefulWidget {
  final Color color;
  final int index;

  const ColorBox({
    Key? key,
    required this.color,
    required this.index,
  }) : super(key: key);

  @override
  _ColorBoxState createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> with AutomaticKeepAliveClientMixin {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checked = false;
    print('-----_ColorBoxState#initState---${widget.index}-------');
  }

  @override
  void dispose() {
    print('-----_ColorBoxState#dispose---${widget.index}-------');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      alignment: Alignment.center,
      height: 50,
      color: widget.color,
      child: Row(
        children: [
          const SizedBox(width: 60),
          Checkbox(
            value: _checked,
            onChanged: (bool? v) {
              setState(() {
                _checked = v??false;
              });
            },
          ),
          Text(
            "index ${widget.index}: ${colorString(widget.color)}",
            style: const TextStyle(color: Colors.white, shadows: [
              Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
            ]),
          ),
        ],
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  @override
  bool get wantKeepAlive => true;
}

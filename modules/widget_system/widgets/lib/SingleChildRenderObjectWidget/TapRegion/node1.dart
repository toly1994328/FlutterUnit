import 'package:flutter/material.dart';

class TapRegionDemo1 extends StatefulWidget {
  const TapRegionDemo1({super.key});

  @override
  State<TapRegionDemo1> createState() => _TapRegionDemo1State();
}

class _TapRegionDemo1State extends State<TapRegionDemo1> {
  String info = 'Tap any where';

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: _onTapOutside,
      onTapInside: _onTapInside,
      child: Container(
        alignment: Alignment.center,
        height: 64,
        width: 160,
        color: isOut ? Colors.grey : Colors.blue,
        child: Text(
          info,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  bool get isOut => info.contains('TapOutside');

  void _onTapOutside(PointerDownEvent event) {
    setState(() {
      info = "TapOutside:\n${event.position}";
    });
  }

  void _onTapInside(PointerDownEvent event) {
    setState(() {
      info = "TapInside:\n${event.position}";
    });
  }
}

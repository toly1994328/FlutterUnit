import 'package:flutter/material.dart';

class AnimatedFractionallySizedBoxDemo extends StatefulWidget {
  const AnimatedFractionallySizedBoxDemo({super.key});

  @override
  State createState() => _AnimatedFractionallySizedBoxDemoState();
}

class _AnimatedFractionallySizedBoxDemoState
    extends State<AnimatedFractionallySizedBoxDemo> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              selected = !selected;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCell(),
              const SizedBox(height: 4),
              const Text('点击面板')
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCell() {
    return SizedBox(
      width: 200,
      height: 200,
      child: ColoredBox(
        color: Colors.red,
        child: AnimatedFractionallySizedBox(
          widthFactor: selected ? 0.25 : 0.75,
          heightFactor: selected ? 0.75 : 0.25,
          alignment: selected ? Alignment.topLeft : Alignment.bottomRight,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: const ColoredBox(
            color: Colors.blue,
            child: FlutterLogo(size: 75),
          ),
        ),
      ),
    );
  }
}

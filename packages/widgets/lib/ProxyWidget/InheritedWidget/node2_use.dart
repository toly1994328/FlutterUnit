
import 'package:flutter/material.dart';

class InheritedCounter extends InheritedWidget {
  const InheritedCounter({
    super.key,
    this.color,
    this.counter,
    required super.child,
  });

  final Color? color;
  final int? counter;

  static InheritedCounter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedCounter>();
  }

  @override
  bool updateShouldNotify(InheritedCounter oldWidget) {
    return color != oldWidget.color || counter != oldWidget.counter;
  }
}

class InheritedModelDemo extends StatefulWidget {
  const InheritedModelDemo({super.key});

  @override
  State<InheritedModelDemo> createState() => _InheritedModelDemoState();
}

class _InheritedModelDemoState extends State<InheritedModelDemo> {
  int _counter = 0;
  late Color _color = colors.first;

  final List<Color> colors = const [
    Colors.black,
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleIconButton(
              color: Colors.green,
              icon: Icons.remove,
              onPressed: _decrease,
            ),
            InheritedCounter(
              color: _color,
              counter: _counter,
              child: const BoxDecorationWrap(),
            ),
            CircleIconButton(
              color: Colors.blue,
              icon: Icons.add,
              onPressed: _increase,
            ),
          ],
        ),
        const SizedBox(height: 20),
        ColorSelector(
          colors: colors,
          activeColor: _color,
          onSelect: _onSelectColor,
        )
      ],
    );
  }

  void _increase() {
    setState(() => _counter += 1);
  }

  void _decrease() {
    setState(() => _counter -= 1);
  }

  void _onSelectColor(Color value) {
    setState(() {
      _color = value;
    });
  }
}

class CircleIconButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const CircleIconButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xFFDFDFDF),
          shape: BoxShape.circle,
          // border: Border.all(width: 14.0, color: Color(0xFFDFDFDF))
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              // border: Border.all(width: 14.0, color: Color(0xFFDFDFDF))
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class ColorSelector extends StatelessWidget {
  final List<Color> colors;
  final ValueChanged<Color> onSelect;
  final Color activeColor;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.activeColor,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: colors
          .map((e) => GestureDetector(
                onTap: () => onSelect(e),
                child: _buildCircle(e),
              ))
          .toList(),
    );
  }

  Widget _buildCircle(Color color) {
    return CircleAvatar(
      radius: 12,
      child: color == activeColor
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
          : null,
      backgroundColor: color,
    );
  }
}

class BoxDecorationWrap extends StatelessWidget {
  const BoxDecorationWrap({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = InheritedCounter.of(context)?.color ?? Colors.black;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: const CounterText(),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: color,
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 0))
          ]),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final Color? color = InheritedCounter.of(context)?.color;
    final int counter = InheritedCounter.of(context)?.counter??0;
    return Text(
      "Counter = $counter",
      style: TextStyle(color: color,fontWeight: FontWeight.bold),
    );
  }
}

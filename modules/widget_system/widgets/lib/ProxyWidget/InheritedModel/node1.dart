import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com

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
            _CircleIconButton(
              color: Colors.green,
              icon: Icons.remove,
              onPressed: _decrease,
            ),
            CounterModel(
              color: _color,
              counter: _counter,
              child: const _BoxDecorationWrap(),
            ),
            _CircleIconButton(
              color: Colors.blue,
              icon: Icons.add,
              onPressed: _increase,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ColorSelector(
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
enum CounterAspect { color, value }

class CounterModel extends InheritedModel<CounterAspect> {
  const CounterModel({
    super.key,
    this.color,
    this.counter,
    required super.child,
  });

  final Color? color;
  final int? counter;

  static CounterModel? of<T>(BuildContext context,CounterAspect aspect){
    return InheritedModel.inheritFrom<CounterModel>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(CounterModel oldWidget) {
    return color != oldWidget.color || counter != oldWidget.counter;
  }

  @override
  bool updateShouldNotifyDependent(CounterModel oldWidget, Set<CounterAspect> dependencies) {
    if (color != oldWidget.color && dependencies.contains(CounterAspect.color)) {
      return true;
    }
    if (counter != oldWidget.counter && dependencies.contains(CounterAspect.value)) {
      return true;
    }
    return false;
  }
}

class _CircleIconButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _CircleIconButton(
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

class _ColorSelector extends StatelessWidget {
  final List<Color> colors;
  final ValueChanged<Color> onSelect;
  final Color activeColor;

  const _ColorSelector({
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

class _BoxDecorationWrap extends StatefulWidget {
  const _BoxDecorationWrap({super.key});

  @override
  State<_BoxDecorationWrap> createState() => _BoxDecorationWrapState();
}

class _BoxDecorationWrapState extends State<_BoxDecorationWrap> {

  @override
  void didChangeDependencies() {
    print("======BoxDecorationWrap#didChangeDependencies=========");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = CounterModel.of(context,CounterAspect.color)?.color ?? Colors.black;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: const _CounterText(),
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

class _CounterText extends StatefulWidget {
  const _CounterText({super.key});

  @override
  State<_CounterText> createState() => _CounterTextState();
}

class _CounterTextState extends State<_CounterText> {
  @override
  void didChangeDependencies() {
    print("======CounterText#didChangeDependencies=========");
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final Color color = CounterModel.of(context,CounterAspect.color)?.color ?? Colors.black;
    final int counter = CounterModel.of(context,CounterAspect.value)?.counter ?? 0;
    return Text(
      "Counter = $counter",
      style: TextStyle(color: color,fontWeight: FontWeight.bold),
    );
  }
}

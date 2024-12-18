import 'package:flutter/material.dart';

class TextFieldTapRegionDemo1 extends StatefulWidget {
  const TextFieldTapRegionDemo1({super.key});

  @override
  State<TextFieldTapRegionDemo1> createState() => _TextFieldTapRegionDemo1State();
}

class _TextFieldTapRegionDemo1State extends State<TextFieldTapRegionDemo1> {
  TextEditingController controller = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Row(
        children: [
          Expanded(child: _buildInput()),
          const SizedBox(width: 8),
          TextFieldTapRegion(child: buildButtons())
        ],
      ),
    );
  }

  Widget _buildInput() {
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: _onChange,
      controller: controller,
      textAlign: TextAlign.center,
    );
  }

  void _onChange(String value) {}

  Widget buildButtons() {
    ButtonStyle style = circleStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlinedButton(
          style: style,
          onPressed: _increment,
          child: const Icon(Icons.add, size: 16),
        ),
        const SizedBox(height: 2),
        OutlinedButton(
          onPressed: _decrement,
          style: style,
          child: const Icon(Icons.remove, size: 16),
        ),
      ],
    );
  }

  ButtonStyle get circleStyle => OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: EdgeInsets.zero,
        minimumSize: const Size(32, 32),
        maximumSize: const Size(32, 32),
      );

  void _increment() {
    int value = int.tryParse(controller.text) ?? 0;
    _updateText('${value + 1}', collapsed: true);
  }

  void _decrement() {
    int value = int.tryParse(controller.text) ?? 0;
    _updateText('${value - 1}', collapsed: true);
  }

  void _updateText(String text, {bool collapsed = true}) {
    if (text != controller.text) {
      controller.value = TextEditingValue(
        text: text,
      );
    }
  }
}

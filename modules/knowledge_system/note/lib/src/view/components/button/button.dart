import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;

  const Button({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Wrap(
        spacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          ),
          Text(
            "新增",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      style: FillButtonPalette(
        foregroundPalette: const Palette.all(Colors.white),
        borderRadius: BorderRadius.circular(6),
        backgroundPalette: const Palette(
          normal: Color(0xff1890ff),
          hover: Color(0xff40a9ff),
          pressed: Color(0xff096dd9),
        ),
      ).style,
    );
  }
}

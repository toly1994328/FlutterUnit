import 'package:app/app.dart';
import 'package:flutter/material.dart';

class SimpleDeskTopBar extends StatelessWidget {
  final Widget? leading;

  const SimpleDeskTopBar({super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    return DragToMoveAreaNoDouble(
      child: Container(
        height: 64,
        color: Colors.white,
        child: Row(
          children: [
            if (leading != null) Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: leading!,
            ),
            const Spacer(),
            const SizedBox(
              width: 20,
            ),
            const WindowButtons(),
          ],
        ),
      ),
    );
  }
}

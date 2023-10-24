import 'package:app/app.dart';
import 'package:flutter/material.dart';

class SimpleDeskTopBar extends StatelessWidget {
  final Widget? leading;

  const SimpleDeskTopBar({super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    return DragToMoveAreaNoDouble(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 64,
        color: Colors.white,
        child: Row(
          children: [
            if (leading != null) leading!,
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

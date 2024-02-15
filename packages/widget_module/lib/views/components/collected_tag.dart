import 'package:flutter/material.dart';
import 'package:l10n/ext.dart';
import 'package:wrapper/wrapper.dart';

class CollectedTag extends StatelessWidget {
  const CollectedTag({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = Theme.of(context).primaryColor;
    String text = context.l10n.favorite;
    return Wrapper.just(
      radius: 10,
      color: isDark ? const Color(0xff292A2D) : const Color(0xffF3F3F5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        text,
        style: TextStyle(color: color, height: 1, fontSize: 10, shadows: [
          Shadow(
            color: isDark ? Colors.black : Colors.white,
            blurRadius: 2,
            offset: const Offset(1, 1),
          )
        ]),
      ),
    );
  }
}

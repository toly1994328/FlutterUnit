import 'package:flutter/material.dart';

class SizeTightConstraint extends StatelessWidget {
  final String info;

  const SizeTightConstraint({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
   Color color = Theme.of(context).primaryColor;
    return LayoutBuilder(
      builder: (ctx,cts)=>ColoredBox(
        color: color,
        child: SizedBox(
          width: 150,
          height: 100,
          child: Center(
              child: Text(
            '$info\n当前约束:\n${cts.toString().replaceAll('BoxConstraints', '')}',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}

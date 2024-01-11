import 'package:flutter/material.dart';
import 'painter.dart';
import 'config.dart';


class BufengPanel extends StatefulWidget {
  const BufengPanel({Key? key}) : super(key: key);

  @override
  State<BufengPanel> createState() => _BufengPanelState();
}

class _BufengPanelState extends State<BufengPanel> {
  final Config config = Config(
    size: const Size(200, 200),
  );

  void addNeedle({int count = 1}) {
    for (int i = 0; i < count; i++) {
      config.addNeedle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: CustomPaint(
            painter: PiPainter(config),
            size: config.size,
          ),
        ),
        Positioned(
          right: 0,
          top: 10,
          child: Row(
            children: [
              IconButton(onPressed: addNeedle, icon: const Icon(Icons.add)),
              IconButton(onPressed: () => addNeedle(count: 100), icon: const Icon(Icons.add_chart)),
              IconButton(onPressed: config.clear, icon: const Icon(Icons.refresh)),
            ],
          ),
        )
      ],
    );

    //   Scaffold(
    //   appBar: AppBar(
    //     title: const Text('蒲丰投针试验'),
    //     actions:
    //     [
    //       IconButton(onPressed: addNeedle, icon: const Icon(Icons.add)),
    //       IconButton(onPressed: () => addNeedle(count: 100), icon: const Icon(Icons.add_chart)),
    //       IconButton(onPressed: config.clear, icon: const Icon(Icons.refresh)),
    //     ],
    //   ),
    //   body: Center(
    //     child: ,
    //   ),
    // );
  }
}

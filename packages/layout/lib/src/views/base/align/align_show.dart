import 'package:flutter/material.dart';

class AlignShow extends StatelessWidget {
  const AlignShow({super.key});

  final List<Alignment> alignments = const [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  final List<String> alignmentsInfo = const [
    "topLeft",
    "topCenter",
    "topRight",
    "centerLeft",
    "center",
    "centerRight",
    "bottomLeft",
    "bottomCenter",
    "bottomRight",
  ];

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      fontSize: 12
    );
    return Center(
      child: Wrap(
          children: alignments
              .toList()
              .map((mode) => Column(children: <Widget>[
                    Container(
                        margin: const EdgeInsets.all(5),
                        width: 150,
                        height: 100,
                        color: Colors.grey.withAlpha(88),
                        child: Align(
                            child: Container(
                              width: 30,
                              height: 30,
                              color: Colors.cyanAccent,
                            ),
                            alignment: mode)),
                    Text(
                      alignmentsInfo[alignments.indexOf(mode)],
                      style: style,
                    )
                  ]))
              .toList()),
    );
  }
}

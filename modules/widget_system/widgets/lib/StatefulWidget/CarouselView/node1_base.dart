// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class CarouselNode1 extends StatefulWidget {
  const CarouselNode1({super.key});

  @override
  State<CarouselNode1> createState() => _CarouselNode1State();
}

class _CarouselNode1State extends State<CarouselNode1> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 160),
      child: CarouselView(
        itemExtent: 260,
        shrinkExtent: 160,
        children: List<Widget>.generate(20, (int index) {
          return UncontainedLayoutCard(index: index, label: 'Item $index');
        }),
      ),
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    super.key,
    required this.index,
    required this.label,
  });

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.5),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.clip,
          softWrap: false,
        ),
      ),
    );
  }
}

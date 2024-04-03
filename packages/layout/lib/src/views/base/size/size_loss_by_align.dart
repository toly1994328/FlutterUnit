import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:layout/src/views/components/grid_xy_layout.dart';

import 'size_tight_constraint.dart';

class LossDisplay extends StatelessWidget {
  const LossDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return GridXYLayout(
      capacity: (2, 2),
      xyBuilder: ((int, int) pos) => switch (pos) {
        (0, 0) => const Align(child: SizeTightConstraint(info: 'Align 放宽约束')),
        (0, 1) => const Row(children: [SizeTightConstraint(info: 'Row 放宽约束')]),
        (1, 0) => const Scaffold(
            backgroundColor: Colors.transparent,
            body: SizeTightConstraint(info: 'Scaffold 放宽约束'),
          ),
        (1, 1) => const Column(
            children: [SizeTightConstraint(info: 'Column 放宽约束')],
          ),
        _ => const SizedBox()
      },
    );
  }
}

class SizeLossByAlign extends StatelessWidget {
  const SizeLossByAlign({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: ColoredBox(
        color: Colors.redAccent,
        child: SizedBox(
          width: 120,
          height: 80,
          child: Center(
              child: Text(
            'Align 放宽约束',
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}

class SizeLossByRow extends StatelessWidget {
  const SizeLossByRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        ColoredBox(
          color: Colors.redAccent,
          child: SizedBox(
            width: 150,
            height: 100,
            child: Center(
                child: Text(
              'Row 放宽约束',
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }
}

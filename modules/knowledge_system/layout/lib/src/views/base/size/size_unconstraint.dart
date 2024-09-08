import 'package:flutter/material.dart';
import 'package:layout/src/views/base/size/size_tight_constraint.dart';

class SizeUnconstrain extends StatelessWidget {
  const SizeUnconstrain({super.key});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizeTightConstraint(info: "通过 UnconstrainedBox 解除约束",),
    );
  }
}


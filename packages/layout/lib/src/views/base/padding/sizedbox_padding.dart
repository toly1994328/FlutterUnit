
import 'package:flutter/material.dart';

import 'inner_padding.dart';

class SizedBoxPadding extends StatelessWidget {
  const SizedBoxPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InnerPadding(),
        SizedBox(width: 24),
        InnerPadding(),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BackgroundShower extends StatelessWidget {
  const BackgroundShower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Opacity(
      opacity: 0.05,
      child: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sabar.webp'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(400),
                topLeft: Radius.circular(400))),
      ),
    );
  }
}

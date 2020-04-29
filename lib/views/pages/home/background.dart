import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.05,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage('assets/images/sabar.jpg'),
                fit: BoxFit.cover),
            borderRadius: const BorderRadius.only(
                bottomRight: const Radius.circular(400),
                topLeft: const Radius.circular(400))),
      ),
    );
  }
}
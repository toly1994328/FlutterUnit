// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedRotationDemo extends StatefulWidget {
  const AnimatedRotationDemo({super.key});

  @override
  State<AnimatedRotationDemo> createState() => _AnimatedRotationDemoState();
}

class _AnimatedRotationDemoState extends State<AnimatedRotationDemo> {
  double _turns = 0;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: GridPaper(
                  color: Colors.blue.withOpacity(0.1),
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: AnimatedRotation(
                        turns: _turns,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: Container(
                          color: Colors.red,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('scale:${_turns.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium),
              Expanded(
                child: Slider(
                  min: 0,
                  max: 1,
                  value: _turns,
                  onChanged: (double value) {
                    setState(() {
                      _turns = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 48.0),
            ],
          ),
        ],
      ),
    );
  }
}

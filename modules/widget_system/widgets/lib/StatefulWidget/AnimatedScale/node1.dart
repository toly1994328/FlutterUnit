// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';


class AnimatedScaleDemo extends StatefulWidget {
  const AnimatedScaleDemo({super.key});

  @override
  State<AnimatedScaleDemo> createState() => _AnimatedScaleDemoState();
}

class _AnimatedScaleDemoState extends State<AnimatedScaleDemo> {
  double _scale = 1;

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
                      child: AnimatedScale(
                        scale: _scale,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: Container(color: Colors.red,height: 40,width: 40,),
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
              Text('scale:${_scale.toStringAsFixed(1)}', style: textTheme.bodyMedium),
              Expanded(
                child: Slider(
                  min: 0,
                  max: 5.0,
                  value: _scale,
                  onChanged: (double value) {
                    setState(() {
                      _scale = value;
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

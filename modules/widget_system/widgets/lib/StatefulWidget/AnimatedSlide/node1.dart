// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';


class AnimatedSlideDemo extends StatefulWidget {
  const AnimatedSlideDemo({super.key});

  @override
  State<AnimatedSlideDemo> createState() => _AnimatedSlideDemoState();
}

class _AnimatedSlideDemoState extends State<AnimatedSlideDemo> {
  Offset offset = Offset.zero;

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
                  // alignment: Alignment.center,
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: AnimatedSlide(
                        offset: offset,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: Container(color: Colors.red,height: 40,width: 40,),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Column(
                  children: <Widget>[
                    Text('Y:${offset.dy.toStringAsFixed(1)}', style: textTheme.bodyMedium),
                    Expanded(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Slider(
                          min: -2.0,
                          max: 2.0,
                          value: offset.dy,
                          onChanged: (double value) {
                            setState(() {
                              offset = Offset(offset.dx, value);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('X:${offset.dx.toStringAsFixed(1)}', style: textTheme.bodyMedium),
              Expanded(
                child: Slider(
                  min: -4.0,
                  max: 4.0,
                  value: offset.dx,
                  onChanged: (double value) {
                    setState(() {
                      offset = Offset(value, offset.dy);
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

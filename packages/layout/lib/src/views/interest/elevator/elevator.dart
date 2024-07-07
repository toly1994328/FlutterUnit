// Copyright 2014 The 星星. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:     星星
// CreateTime:  2024-07-02
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';
import 'package:tolyui/basic/basic.dart';

class ElevatorRoom extends StatefulWidget {
  const ElevatorRoom({super.key});

  @override
  State<ElevatorRoom> createState() => _ElevatorRoomState();
}

class _ElevatorRoomState extends State<ElevatorRoom> {
  int  lv = 1 ;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double  roomHeight = constraints.maxHeight/20;

        return Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Stack(
              children: [
                Column(
                  children: List.generate(
                      20,
                      (index) => Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                            width: constraints.minWidth / 10,
                            height: roomHeight,
                          )),
                ),
                Positioned(
                  bottom: roomHeight * ( lv - 1 ),
                  child: elevator(  width: constraints.minWidth / 10,
                    height: constraints.maxHeight / 20,),
                ),
              ],
            ),
            Column(
              children: [
                TolyAction(child: Icon(Icons.arrow_upward_outlined), onTap:upRoom),
                TolyAction(child: Icon(Icons.arrow_downward_outlined), onTap:downRoom),

              ],
            ),
          ],
        );
      },
    );
  }

  void upRoom() {
    lv+=1;
    setState(() {

    });
  }

  void downRoom() {
    
    lv-=1;
    setState(() {

    });
  }
  Widget elevator({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      color: Colors.blue,
    );
  }
}

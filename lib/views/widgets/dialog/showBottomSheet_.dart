import 'package:flutter/material.dart';

bool _showing=false;
showBottomSheet_(BuildContext context) {
  var bottomSheet = BottomSheet(
      onClosing: () {},
      builder: (context) => (Container(
        color: Color(0xdde3fbf6),
        height: 150,
        child: Center(
          child: Image.asset("assets/images/wy_300x200_filter.jpg"),
        ),
      )));
  if(_showing){
    Navigator.of(context).pop();
  }else{
    Scaffold.of(context).showBottomSheet(bottomSheet.builder); //这样就行了
  }
  _showing=!_showing;
}
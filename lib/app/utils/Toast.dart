import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toast {
  static toast(BuildContext context, String msg,
      {duration = const Duration(milliseconds: 600)}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: duration,
      backgroundColor: Theme.of(context).primaryColor,
    ));
  }
}

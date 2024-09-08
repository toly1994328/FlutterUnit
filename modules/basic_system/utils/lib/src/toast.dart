import 'package:flutter/material.dart';

class Toast {
  static toast(BuildContext context, String msg,
      {duration = const Duration(milliseconds: 600),
        Color? color,
        SnackBarAction? action}) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: duration,
      action: action,
      backgroundColor: color??Theme.of(context).primaryColor,
    ));
  }

  static void error(BuildContext context,String msg){
    toast(context,msg,  color:Colors.red, );
  }

  static  void warning(BuildContext context,String msg){
    toast(context,msg, color:Colors.orange, );
  }

  static  void success(BuildContext context,String msg){
    toast(context,msg, color:Theme.of(context).primaryColor, );
  }

  static  void green(BuildContext context,String msg){
    toast(context,msg, color:Colors.green, );
  }
}

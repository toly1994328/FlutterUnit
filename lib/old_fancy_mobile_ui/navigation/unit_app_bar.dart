

import 'package:flutter/material.dart';

class UnitAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const UnitAppbar({Key? key,required this.title, this.leading,this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      actions: actions,
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: const BackButton(color: Colors.black,),
      title: Text(title,style: const TextStyle(color: Colors.black,fontSize: 16),),
    );
  }

  @override
  Size get preferredSize =>  AppBar().preferredSize;
}
